From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Implement git commit as a builtin command.
Date: Fri, 02 Nov 2007 02:37:43 -0700
Message-ID: <7vsl3p3s48.fsf@gitster.siamese.dyndns.org>
References: <1193944163-22892-1-git-send-email-krh@redhat.com>
	<fgdc3m$miq$1@ger.gmane.org>
	<20071102092720.GA30468@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Karl =?utf-8?Q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Fri Nov 02 10:38:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Insyc-0002yy-0I
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 10:38:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752797AbXKBJhv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Nov 2007 05:37:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752770AbXKBJhv
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 05:37:51 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:55712 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752687AbXKBJhu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Nov 2007 05:37:50 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 3BCCC2F0;
	Fri,  2 Nov 2007 05:38:11 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id BEA7E90617;
	Fri,  2 Nov 2007 05:38:07 -0400 (EDT)
In-Reply-To: <20071102092720.GA30468@diana.vm.bytemark.co.uk> (Karl
	=?utf-8?Q?Hasselstr=C3=B6m's?= message of "Fri, 2 Nov 2007 10:27:20 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63085>

Karl Hasselstr=C3=B6m <kha@treskal.com> writes:

> On 2007-11-01 21:14:45 +0100, Jakub Narebski wrote:
>
>> Kristian H?gsberg wrote:
>>
>> > Move git-commit.sh to contrib/examples.
>>
>> Just a note: you might want to use "git format-patch -M".
>
> I wonder if it would be such a bad idea to make this the default. It
> seems like _everyone_ who should be using it forget it. And the numbe=
r
> of patches made for human or git consumption is probably vastly large=
r
> than the number of patches made for consumption by other tools.

On this mailing list, we can pretty much assume that renaming
diff can be applied by people.  But outside world is a different
story.
