From: =?UTF-8?B?w5h5dmluZCBBLiBIb2xt?= <sunny@sunbase.org>
Subject: Re: [patch 00/16] Portability Patches for git-1.7.1 (v4)
Date: Sun, 2 May 2010 15:00:40 +0200
Message-ID: <s2gc4c738cd1005020600s1c440fc7gec38823196cc1e5b@mail.gmail.com>
References: <20100427135708.258636000@mlists.thewrittenword.com> 
	<4BD7032D.9050508@drmicha.warpmail.net> <4BDC744E.4050006@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Gary V. Vaughan" <git@mlists.thewrittenword.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 02 15:01:15 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8YnK-0000m7-Td
	for gcvg-git-2@lo.gmane.org; Sun, 02 May 2010 15:01:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755231Ab0EBNBH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 May 2010 09:01:07 -0400
Received: from mail-yw0-f198.google.com ([209.85.211.198]:65073 "EHLO
	mail-yw0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751754Ab0EBNBF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 May 2010 09:01:05 -0400
Received: by ywh36 with SMTP id 36so755051ywh.4
        for <git@vger.kernel.org>; Sun, 02 May 2010 06:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:sender:received
         :in-reply-to:references:from:date:x-google-sender-auth:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=5usN8llelF5RzkHZtfhQzrWpfgJL4E1KECg0+3JRPN8=;
        b=Zgs+fPcBLlkJbThIHeg5o3s7zNdHF427EkGbHKF44mXB63MJGmbXKvhmbcZhdWFytK
         3FNajqexMt87awrTvlBUCsV5rZi2QVq4aBfHj5USFu+Jus2VpO+30NMGRCbc6N2iuCqw
         vsxiGe5IMOEZJZX6/jd/YjRx0PmRPWWyl9ous=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=atADLUiqtKiAYq/ONZ8/7ShqaMn0bWjAM1wb5hVB1Ry3ZzqQbHXBLK6uDBjL7h/AOw
         WHQbDPrTJVXq8HzfM7fiOwOUQT/WEe4ReC8GkZ6EzR9Goq6Q5Wnt9efMpwFISS2b3nqA
         042my/q8EufkeXFApsLCLjRm/1ViC9wg+axWA=
Received: by 10.101.138.30 with SMTP id q30mr458471ann.18.1272805262190; Sun, 
	02 May 2010 06:01:02 -0700 (PDT)
Received: by 10.100.41.3 with HTTP; Sun, 2 May 2010 06:00:40 -0700 (PDT)
In-Reply-To: <4BDC744E.4050006@drmicha.warpmail.net>
X-Google-Sender-Auth: eef3204f970ed8bf
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146170>

On 1 May 2010 20:34, Michael J Gruber <git@drmicha.warpmail.net> wrote:
> Gary V. Vaughan venit, vidit, dixit 27.04.2010 15:57:
> > Here are the portability patches we needed at TWW to enable git-1.7=
=2E1 to
> > compile and run on all of the wide range of Unix machines we suppor=
t.
>
> OK, unsurprsingly, tests still pass on Linux (Fedora 12 x86_64).
> If anyone wants to try, the series can be found at
>
> git://repo.or.cz/git/mjg.git
>
> in branch
>
> gvv/platform-compatibility

The patches compiles fine and runs the test suite without errors on Ubu=
ntu 9.10
(x86_64). Tested original branch (v1.7.1-16-ga32be36, branched on v1.7.=
1) and
rebase on current master (ddb27a5a)

Cheers,
=C3=98yvind A. Holm
