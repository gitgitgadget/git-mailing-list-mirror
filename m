From: greened@obbligato.org (David A. Greene)
Subject: Re: [PATCH v3 contrib/subtree 1/1] Add a test for subtree rebase that loses commits
Date: Sun, 17 Jan 2016 17:36:19 -0600
Message-ID: <87h9ibaido.fsf@waller.obbligato.org>
References: <CAPig+cQ6Dfvc4dkQVZ6BqzD76nZ4mCcqkO4eAecrMENKWtgWEg@mail.gmail.com>
	<ec1decfc5fd463f1e78a5aa2636c24fb11e80a62.1453072387.git.greened@obbligato.org>
	<CAPig+cTMAnbyT3-FFN4juUooosiydOCX-ETwTghpnKoOeXcMpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Jan 18 00:36:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aKws4-0001TQ-FH
	for gcvg-git-2@plane.gmane.org; Mon, 18 Jan 2016 00:36:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753088AbcAQXga (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2016 18:36:30 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:33009 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752845AbcAQXg2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2016 18:36:28 -0500
Received: from chippewa-nat.cray.com ([136.162.34.1] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
	(Exim 4.85)
	(envelope-from <greened@obbligato.org>)
	id 1aKwtK-0003g6-Pc; Sun, 17 Jan 2016 17:37:51 -0600
In-Reply-To: <CAPig+cTMAnbyT3-FFN4juUooosiydOCX-ETwTghpnKoOeXcMpQ@mail.gmail.com>
	(Eric Sunshine's message of "Sun, 17 Jan 2016 18:32:44 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  Eric Sunshine <sunshine@sunshineco.com> writes: > On Sun,
   Jan 17, 2016 at 6:13 PM, David Greene <greened@obbligato.org> wrote: >> From:
    David A. Greene <greened@obbligato.org> >> >> This test merges an external
    tree in as a subtree, makes some commits >> on top of it and splits it back
    out. In the process the added commits >> are lost or the rebase aborts with
    an internal error. The tests are >> marked to expect failure so that we don't
    forget to fix it. >> >> Signed-off-by: David A. Greene <greened@obbligato.org>
    >> --- >> >> Notes: >> Ch 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284275>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Sun, Jan 17, 2016 at 6:13 PM, David Greene <greened@obbligato.org> wrote:
>> From: David A. Greene <greened@obbligato.org>
>>
>> This test merges an external tree in as a subtree, makes some commits
>> on top of it and splits it back out.  In the process the added commits
>> are lost or the rebase aborts with an internal error.  The tests are
>> marked to expect failure so that we don't forget to fix it.
>>
>> Signed-off-by: David A. Greene <greened@obbligato.org>
>> ---
>>
>> Notes:
>>     Change History:
>>
>>     v1 - Initial version
>>     v2 - Additional tests and code cleanup
>>     v3 - Remove check_equal, mark comments on failure and remove
>>          test_debug statements
>
> Hmm, the v3 changes described here don't appear in this version. In
> fact, v2 and v3 are identical.

Dang, you caught me before I could reply.  :)

Yes, I botched this one.  Sending v4... ;)

                          -David
