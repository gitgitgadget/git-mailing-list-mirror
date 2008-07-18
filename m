From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: Addremove equivalent [was: Re: Considering teaching plumbing to users harmful]
Date: Fri, 18 Jul 2008 16:18:41 -0400
Message-ID: <76718490807181318o228171f9j836aaca2edb9b377@mail.gmail.com>
References: <alpine.DEB.1.00.0807161804400.8950@racer>
	 <7vmykhpn6z.fsf@gitster.siamese.dyndns.org>
	 <20080717155538.GE11759@fieldses.org>
	 <alpine.DEB.1.00.0807171915420.8986@racer>
	 <7vtzeofjpi.fsf@gitster.siamese.dyndns.org>
	 <alpine.DEB.1.00.0807171940160.8986@racer>
	 <48806897.1080404@fastmail.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Michael J Gruber" <michaeljgruber+gmane@fastmail.fm>
X-From: git-owner@vger.kernel.org Fri Jul 18 22:19:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJwQY-0007gS-TS
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 22:19:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755551AbYGRUSn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 16:18:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756515AbYGRUSn
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 16:18:43 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:22027 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753775AbYGRUSm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 16:18:42 -0400
Received: by yx-out-2324.google.com with SMTP id 8so175450yxm.1
        for <git@vger.kernel.org>; Fri, 18 Jul 2008 13:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=jU0ySVy5dvQuWvjiPpmqNhgHYp7NjLpnvQPz82yn+Yo=;
        b=SFWw06gut1a9VRRz3VXywYOlB1PjoRByT7UvJMLBFfeuyqGWYWAAonVUO0NCbHIIQx
         O5IaTuGzScqmSp2q6AyGbur//bu0SxJJGTyvubHRk5WOvONCOSPR0eW8EvjdGyh+nqgJ
         KOqWQvyRkhqYrkMgFzvfGAkopqYL1Y29CIx5c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=SH6nyN0IAUcoaI54mCpU6G5gxlLhiVWQ/AeO+6dU8tbvbAYbpVGCsI4D0C1xT4ksEu
         EbjrY8tjTuvLw6z9buEgx3H53OFqdH1ogN38fgYEaqXCGiBz6atb4ydFMhMJHMxd3E4N
         Qkg1mE1i5pYI9D3Zy7h+p+ef/pZQmsqfQpBow=
Received: by 10.150.52.2 with SMTP id z2mr606933ybz.45.1216412321318;
        Fri, 18 Jul 2008 13:18:41 -0700 (PDT)
Received: by 10.150.149.15 with HTTP; Fri, 18 Jul 2008 13:18:41 -0700 (PDT)
In-Reply-To: <48806897.1080404@fastmail.fm>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89076>

On Fri, Jul 18, 2008 at 5:55 AM, Michael J Gruber
<michaeljgruber+gmane@fastmail.fm> wrote:
> sometimes I find my self wanting an "addremove", such as in a situation like

I have the following aliased as "addremove":

  git ls-files -d -m -o -z --exclude-standard \
  | xargs -0 git update-index --add --remove

http://www-cs-students.stanford.edu/~blynn/gitmagic/ch05.html

j.
