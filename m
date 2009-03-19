From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/11] Test on Windows - prequel
Date: Thu, 19 Mar 2009 16:00:09 -0700
Message-ID: <7v8wn16ruu.fsf@gitster.siamese.dyndns.org>
References: <cover.1237410682.git.j6t@kdbg.org>
 <200903192158.46680.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Mar 20 00:01:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkRFE-0005iM-6d
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 00:01:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752800AbZCSXAS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Mar 2009 19:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752273AbZCSXAS
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 19:00:18 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44235 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751720AbZCSXAR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Mar 2009 19:00:17 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B6EA9A3382;
	Thu, 19 Mar 2009 19:00:14 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id B3CC8A3381; Thu,
 19 Mar 2009 19:00:11 -0400 (EDT)
In-Reply-To: <200903192158.46680.j6t@kdbg.org> (Johannes Sixt's message of
 "Thu, 19 Mar 2009 21:58:46 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B525093A-14D9-11DE-95A2-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113854>

Johannes Sixt <j6t@kdbg.org> writes:

> On Mittwoch, 18. M=C3=A4rz 2009, Johannes Sixt wrote:
>> I'm preparing a series of patches that adjust the test suite so that=
 it
>> passes on Windows (MinGW port). This is the initial part of it. Anot=
her
>> dozen or more are to follow. By splitting the series I hope to get
>> earlier feedback.
>>
>> The series is also available from
>>
>>  git://repo.or.cz/git/mingw/j6t.git for-junio
>>
> I've updated the series. Would you please pick up it up from the URL
> above?

I think you have a typo in the "Use 'say'" one ("In on case").  Here is=
 a
diff from what I queued previously but didn't have a chance to merge to=
 'pu':

     test suite: Use 'say' to say something instead of 'test_expect_suc=
cess'

-    Some test scripts report that some tests will be skipped.  They us=
ed
+    Some tests report that some tests will be skipped.  They used
     'test_expect_success' with a trivially successful test.  Nowadays =
we have
     the helper function 'say' for this purpose.

-    t9700-perl-git.sh was using 'say_color' for this kind of reporting=
; change
-    it to a vanilla 'say' for consistency.
+    In on case, 'say_color skip' is replaced by 'say' because the form=
er is
+    not intended as a public API.

     Signed-off-by: Johannes Sixt <j6t@kdbg.org>
-    Signed-off-by: Junio C Hamano <gitster@pobox.com>

Other than that, the interdiff matches what I expected to see.

Thanks.
