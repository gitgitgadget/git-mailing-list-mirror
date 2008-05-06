From: Tim Harper <timcharper@gmail.com>
Subject: Re: [PATCH] I don't known anyone who understands what it means when they do a merge and see "file.txt: needs update". "file.txt: has changes" is much clearer.
Date: Tue, 6 May 2008 15:50:56 -0600
Message-ID: <F1DEC707-3E1B-4211-9F97-171D01B13A8E@gmail.com>
References: <1209798522-13618-1-git-send-email-timcharper@gmail.com> <alpine.DEB.1.00.0805031509170.30431@racer> <7v3aozwcj6.fsf@gitster.siamese.dyndns.org> <3DE78C03-DA35-4CB5-8D3D-0529A89065EC@gmail.com> <7v63tvszgo.fsf@gitster.siamese.dyndns.org> <32541b130805031721n29cf470cx391fe0e8b4943706@mail.gmail.com> <7vtzhesvxu.fsf@gitster.siamese.dyndns.org> <32541b130805050935l7257a5e3t9b44d61abe28db37@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Avery Pennarun" <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 06 23:52:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtV4y-0005qy-BF
	for gcvg-git-2@gmane.org; Tue, 06 May 2008 23:52:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754568AbYEFVvH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2008 17:51:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754570AbYEFVvH
	(ORCPT <rfc822;git-outgoing>); Tue, 6 May 2008 17:51:07 -0400
Received: from wr-out-0506.google.com ([64.233.184.239]:36723 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754546AbYEFVvE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2008 17:51:04 -0400
Received: by wr-out-0506.google.com with SMTP id c48so10105wra.1
        for <git@vger.kernel.org>; Tue, 06 May 2008 14:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to:in-reply-to:content-type:content-transfer-encoding:mime-version:subject:date:references:x-mailer;
        bh=O0Fafh1S81HC4szOFj9oixQDyN5hlanh4T8hYdFH7kk=;
        b=DpHwLmz/ITZcABV2G5Zgz5Y+B0SM0/tDWBGk8IUaZKEAtf0DE/xAS8VlzchGZLQpAEOa6G+RKzGPOQFMRNIzFprRUqXzPioFXBfyNbB2+DW9gHH+2r9mAguQd/Jo8U/w4s5RcTrZCsQrEEJNivNXC4S4KynyTu8Mfm+guZzUyMU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type:content-transfer-encoding:mime-version:subject:date:references:x-mailer;
        b=kSn9uwE2wUnU66Ix/tgrqRf0MeyhH5BYMggjeCIxnSPKRN+wrG7f5avICn56ZD4xUpR5XWr6pH2A2D+guagq1oU102efYzpMp+e3MOvbPw8J1gggHQow53O/KCMgsbvHzJnAdfdH5fuAH7c+qOListsCyQTN0raQ+G35q4XVjlA=
Received: by 10.143.8.10 with SMTP id l10mr545649wfi.181.1210110662025;
        Tue, 06 May 2008 14:51:02 -0700 (PDT)
Received: from ?10.0.1.193? ( [66.182.89.5])
        by mx.google.com with ESMTPS id 31sm2763253wff.10.2008.05.06.14.50.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 06 May 2008 14:50:59 -0700 (PDT)
In-Reply-To: <32541b130805050935l7257a5e3t9b44d61abe28db37@mail.gmail.com>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81382>

Yeah: I was thinking about it earlier and came at the same conclusion.

There's a "porcelain" interface for a lot of commands.  Does the  
concept need to be furthered for this case?

On another note - I've been running with this change for several days,  
and everything seems to be alright.

Tim



On May 5, 2008, at 10:35 AM, Avery Pennarun wrote:

> On 5/3/08, Junio C Hamano <gitster@pobox.com> wrote:
>> "Avery Pennarun" <apenwarr@gmail.com> writes:
>>> On 5/3/08, Junio C Hamano <gitster@pobox.com> wrote:
>>>> Of course not.  Where does end-user scripts come into play when  
>>>> you are
>>>> running the testsuite?
>>>
>>> I thought user scripts weren't supposed to rely on the porcelain
>>> output?  It seems to change rather frequently anyway.
>>
>> Wasn't the patch about changing output from "update-index --refresh",
>> which is as low as you can get?
>
> Hmm, perhaps the problem then is that we're using plumbing output and
> presenting it to the user as part of the porcelain.  Is there an
> elegant way to fix that?
>
> Avery
