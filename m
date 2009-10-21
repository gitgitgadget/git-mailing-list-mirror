From: B Smith-Mannschott <bsmith.occs@gmail.com>
Subject: Re: Feature request: Store comments on branches
Date: Wed, 21 Oct 2009 15:56:51 +0200
Message-ID: <28c656e20910210656m5ad597b9h7668e33eeb86b096@mail.gmail.com>
References: <20091021133702.GA470@lisa>
	 <18071eea0910210646l41f18deam8c75f1218df7e25a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Patrick Schoenfeld <schoenfeld@debian.org>, git@vger.kernel.org
To: Thomas Adam <thomas.adam22@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 21 15:58:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0bgP-0002kr-QW
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 15:56:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753319AbZJUN4s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2009 09:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751980AbZJUN4s
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Oct 2009 09:56:48 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:57105 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751865AbZJUN4s (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2009 09:56:48 -0400
Received: by ey-out-2122.google.com with SMTP id d26so1075771eyd.5
        for <git@vger.kernel.org>; Wed, 21 Oct 2009 06:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=uTOoRWxVy08sbFOM4L5y99Urk9YjxmkVuA22fucyWYw=;
        b=AihlQIEGwdUw0RL9cRezfEoFTSEVX1QXlKw/jiTt0eJe70iZudoA6gyUXD5nSBpD52
         9N9wAE3nDaB5V3O3rmGuy4l8GzTFVSbmhjpfSO3PNR340BIdcCS/B30DVJm7lnMAFGO6
         6vdBcbmo71dwWW7xB6PTbeyTtjTpIGdckHphc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=K6bTW47WgDFIGIUnM23uKYIsOq2FD3zHU6UNRlzoSeo4Ij+ZCe+M+2K/fMSf6cM53h
         Nc2h705gS1QVihgGAb+HW9037Y0QeH6nbNDoUHm+Mky0qHRDvnKiutVPeUKdJe/1onJb
         gcNY1jnsFSI9MJnAJwt3A1XcMSMQjNqS4Mzhc=
Received: by 10.211.128.15 with SMTP id f15mr2255194ebn.84.1256133411190; Wed, 
	21 Oct 2009 06:56:51 -0700 (PDT)
In-Reply-To: <18071eea0910210646l41f18deam8c75f1218df7e25a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130920>

On Wed, Oct 21, 2009 at 15:46, Thomas Adam <thomas.adam22@gmail.com> wrote:
> 2009/10/21 Patrick Schoenfeld <schoenfeld@debian.org>:
>> What do others think about this? Would this be useful
>> for others, too?
>
> This feature is already being worked on as "git notes" -- see the "pu"
> branch, I think it's still in there, unless it has graduated to next;
> I forget now.

Really? I was under the impression that the nodes were meant to
annotate commits, or more generally things with SHA-1 IDs. (commits,
tress, blobs). The SHA-1 ID a branch uses to refer to its HEAD commit
changes with every commit, and the branch itself doesn't have an ID,
just a name.

// Ben
