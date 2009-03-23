From: "Aaron Gray" <aaronngray.lists@googlemail.com>
Subject: Re: git svn teething problems - initial clone okay - fetches not working
Date: Mon, 23 Mar 2009 22:49:27 -0000
Message-ID: <D9560AEA971144C99A0540C08AAFC3D1@HPLAPTOP>
References: <2BACA6CC2F9647C19C0463120219E694@HPLAPTOP> <49C7F92A.5050809@obry.net> <0381B9A616514FC2A05BACAB07EE3117@HPLAPTOP> <c115fd3c0903231458t7ac8ac69if6b7bdb3a7d8861b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed	reply-type=original
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <pascal@obry.net>, "Git Mailing List" <git@vger.kernel.org>
To: "Tim Visher" <tim.visher@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 23 23:51:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Llsz7-0008LJ-Ou
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 23:51:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755040AbZCWWti convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Mar 2009 18:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754717AbZCWWti
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 18:49:38 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:28124 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751060AbZCWWth (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 18:49:37 -0400
Received: by ey-out-2122.google.com with SMTP id 4so591197eyf.37
        for <git@vger.kernel.org>; Mon, 23 Mar 2009 15:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to:cc
         :references:subject:date:mime-version:content-type
         :content-transfer-encoding:x-priority:x-msmail-priority:x-mailer
         :x-mimeole;
        bh=TnQrDAA292WPb3wLvLeYaBxv/yKLtqWYfR1J/cnx2Fs=;
        b=Nk8WGYnZ/hXNJs02zLiFA5oJ7EbCoM3RIVWnKZdgN10+NEayIOVifjMZdm8LOdxKt+
         SFfucZiZG6+eFp/PS3Y5P2fHpqnbg7CQ+ImpWCckUTPNwGnpCwVCO6ub06t62QFJwQTD
         mjesjjtc1+ua2rKjnpY1WNNckjh0s1rhoCO2Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:from:to:cc:references:subject:date:mime-version
         :content-type:content-transfer-encoding:x-priority:x-msmail-priority
         :x-mailer:x-mimeole;
        b=gV4z6ql6lb36y2JN405qzjmSQjGcfmWptPl+luCRR87F9513ShUxPRo/3KEPQN3PHB
         pUPdtIamfkFzp1RXegTNQq+Vmo51IYQlOzegdk/Xpn3yu6Nr2eKzt+erkELgZikno/SS
         uaty9cqq7n/a+omZuzB0MY8X/Z6RUSU324DL8=
Received: by 10.210.135.17 with SMTP id i17mr2646500ebd.87.1237848574060;
        Mon, 23 Mar 2009 15:49:34 -0700 (PDT)
Received: from HPLAPTOP (aarongray.demon.co.uk [80.177.163.94])
        by mx.google.com with ESMTPS id k5sm5632305nfh.67.2009.03.23.15.49.32
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 23 Mar 2009 15:49:33 -0700 (PDT)
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5512
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5579
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114356>

On Mon, Mar 23, 2009 at 5:31 PM, Aaron Gray
<aaronngray.lists@googlemail.com> wrote:
>> Aaron Gray a =C3=A9crit :
>>>
>>> Anyway I am having the problem that I can do a 'git svn fetch' and =
I see
>>> changes coming in. But the gitweb and another git clone from it do =
not
>>> reflect those changes. The repository is still showing its two days=
 old.
>>
>> You need a:
>>
>>  $ git svn rebase
>
> I tried that.
>
>> to fetch *and* merge the changes into the local tracking branch (mas=
ter
>> by default).
>
> Pascal,
>
> Could you give me a full set of instructions for importing :-
>
>   http://llvm.org/svn/llvm-project/llvm
>

   It sounds like your working directory might be dirty.  Are you sure
   all of your changes have been committed?

Probably. I am getting an error on doing 'git svn rebase' :-

many filenames * : needs update
update---index --refresh: command returned error: 1


Could you please give me the command to import the above SVN repository=
 so I=20
can redo the thing from scratch.

Many thanks in advance,

Aaron
