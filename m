From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH] git stash: one bug and one feature request
Date: Fri, 4 Jan 2008 19:46:51 +0100
Message-ID: <e5bfff550801041046p534b4869l2919494a8e4ef711@mail.gmail.com>
References: <e5bfff550801040814n82f34b2g17c485a207093440@mail.gmail.com>
	 <Pine.LNX.4.64.0801041030420.31161@torch.nrlssc.navy.mil>
	 <477E6D26.9020809@obry.net>
	 <e5bfff550801040944p7f8e722asfa726b34a4a712fa@mail.gmail.com>
	 <477E7439.9090209@nrlssc.navy.mil>
	 <e5bfff550801041005x3ab682dam8535c7bde75038dc@mail.gmail.com>
	 <477E7C3D.8030501@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Pascal Obry" <pascal@obry.net>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Brandon Casey" <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Jan 04 19:47:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JArZl-0002mb-KY
	for gcvg-git-2@gmane.org; Fri, 04 Jan 2008 19:47:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752073AbYADSqz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2008 13:46:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752120AbYADSqz
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jan 2008 13:46:55 -0500
Received: from rv-out-0910.google.com ([209.85.198.190]:26717 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751692AbYADSqy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2008 13:46:54 -0500
Received: by rv-out-0910.google.com with SMTP id k20so6207928rvb.1
        for <git@vger.kernel.org>; Fri, 04 Jan 2008 10:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=8wH6lNK89v1EYPFdSQnEXkZlPyfirk/1aHnZcpEO1ac=;
        b=VZcaf9G64RWKE5bp0fgcioFvYBzBqGPlHB1mYjI4khTli4/grxkc6Fz+qyPslQ458W8uJXUA5xjsB2VPSvUd6CzIE502XOQUz31NiXFhBydDRwb4pXYB6ojADz4rwk31rjfj1svGA6tlic3tihkd/j3tiAPE4xGc45WrDKGQGNk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jGo9C7ahKgrP3gCkTXc62sCVUXNWjaJX0UW1PkaLHFdTe1oBAMXCVnR71AeJao3JZpgdKcXLtlM1a314Hb+vkJXClULH/VL0B/pHY7HLadxiH3D4+KmJa6q8ub6ifBQXkJxEbBuRf3ISA5kWvahsTNGpa0maiZdzSOAVuajQ3kE=
Received: by 10.141.22.1 with SMTP id z1mr9051575rvi.282.1199472411249;
        Fri, 04 Jan 2008 10:46:51 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Fri, 4 Jan 2008 10:46:51 -0800 (PST)
In-Reply-To: <477E7C3D.8030501@nrlssc.navy.mil>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69594>

On Jan 4, 2008 7:34 PM, Brandon Casey <casey@nrlssc.navy.mil> wrote:
>
> Doesn't seem like too far of a stretch.
>

I'm very bad at naming, so I don't argue any more.

Just one thing (that is the only that matters) call this command as
you want but let it take one argument, the name of the reflog to
remove:

git stash drop stash@{3}

should be allowed.

git stash drop

defaults to  stash@{0}

Thanks
Marco
