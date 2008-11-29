From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH 1/2] gitweb: add patch view
Date: Sat, 29 Nov 2008 17:48:13 +0100
Message-ID: <cb7bb73a0811290848j1b77fe89m66ead7cc4f5ca2bb@mail.gmail.com>
References: <1227966071-11104-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <1227966071-11104-2-git-send-email-giuseppe.bilotta@gmail.com>
	 <bd6139dc0811290743s6cf8e534nddd8a09698ea22b9@mail.gmail.com>
	 <200811291710.27891.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: sverre@rabbelier.nl, git@vger.kernel.org,
	"Petr Baudis" <pasky@suse.cz>, "Junio C Hamano" <gitster@pobox.com>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 29 17:49:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6T0f-0000MF-OS
	for gcvg-git-2@gmane.org; Sat, 29 Nov 2008 17:49:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751776AbYK2QsQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Nov 2008 11:48:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751821AbYK2QsQ
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Nov 2008 11:48:16 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:27706 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751577AbYK2QsP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Nov 2008 11:48:15 -0500
Received: by nf-out-0910.google.com with SMTP id d3so976720nfc.21
        for <git@vger.kernel.org>; Sat, 29 Nov 2008 08:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=LrQTsMyzrBngKUfBKHwTp6SP1CwUpfAJxCfie2iMAjk=;
        b=m3GsSSsL5AUZY4L3Bm3mPi1ID9Og816qabBhlTA5mVgYRGVtXGjBOw1Wi7f7bGDooZ
         4gi1u/rbbYBqtNtQzWFa13Oesg4K8zFODWXl23yyggeJ3z4s9AJu+0giSf2py3SeVUS6
         KTxHkudINHJb0YIdEXxdXh0egWtXBSvtxE8B0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=bnDoHd6a/XXfjUCV2Hxx/bXgoWS/PXyFCLoknLivyzyr4RT22xSPgWg/ai5ggVcz8E
         9lS2TwPtTxLJZn1Q+68IUKwHoa5k11tF92YILo0kxAUDWhrOAN8TsHoAXAi38Zd5RshV
         IQHH5W1xA/g1pxkwi05CMifS24AIT79kvnTKI=
Received: by 10.210.144.3 with SMTP id r3mr10337844ebd.115.1227977293475;
        Sat, 29 Nov 2008 08:48:13 -0800 (PST)
Received: by 10.210.79.12 with HTTP; Sat, 29 Nov 2008 08:48:13 -0800 (PST)
In-Reply-To: <200811291710.27891.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101917>

Wow, I honestly didn't expect this idea to be so successful. I thought
I was the only one using gitweb to send patches around, honestly 8-D

On Sat, Nov 29, 2008 at 5:10 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> On Sat, 29 Nov 2008, Sverre Rabbelier wrote:
>>
>> If this does what I think it does I would be very happy with this
>> feature :). Only yesterday I wanted to link someone to a patch I put
>> up on repo.or.cz, but instead ended up telling them to download the
>> snapshot.
>
> True. 'commitdiff_plain' wasn't good enough; what's more it suffers
> from the same ambiguity as 'commitdiff', i.e. it is both means to
> show diff _for_ a commit (perhaps selecting one of parents), and
> showing diff _between_ two commits; the new 'patch' always shows
> diff for a commit, or for a series of commits.

Maybe commitdiff should me renamed to just be 'diff'.

Also, I was in doubt about the name for the new view, and I did
consider 'patchset' (which you mention in your email). I chose to
stick with the shorter form in the end, since many people complain
that gitweb already produces paths that are too long.

-- 
Giuseppe "Oblomov" Bilotta
