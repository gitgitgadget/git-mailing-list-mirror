From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: Re: A few usability question about git diff --cached
Date: Thu, 4 Oct 2007 15:10:45 +0200
Message-ID: <4d8e3fd30710040610m49521fb7ld8f95043c945bf94@mail.gmail.com>
References: <4d8e3fd30710040527j61152b2dh1b073504ba19d490@mail.gmail.com>
	 <20071004125641.GE15339@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Miklos Vajna" <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Thu Oct 04 15:10:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdQTg-0008Ka-52
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 15:10:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755090AbXJDNKs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Oct 2007 09:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754289AbXJDNKs
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 09:10:48 -0400
Received: from wr-out-0506.google.com ([64.233.184.225]:40479 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754252AbXJDNKr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Oct 2007 09:10:47 -0400
Received: by wr-out-0506.google.com with SMTP id 36so131673wra
        for <git@vger.kernel.org>; Thu, 04 Oct 2007 06:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=dpgMXGOZksoHB23s42ireHAI/I8vpSbi4pt7lzEqKe4=;
        b=BmAGuVzMeh7FrL/IHbgYwnHWPm3+RHvFOPteMTzf5H1G2QDj54w4mp9Z0pD5Cu6C33L3xHykhpg4H9gY9nFsudqWs9B4KCLh9qoR9/oDjyWy4fm33zThA25KHogi999k/KSM2NQHIQjq/1POt0YgqZkaJ8CRKb1i8erl/zp0koQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kP1piIXKphkG92a0fpM4tnKilzRUe/wqSbE4TFswqQHheJjoM548y1CuPaQfm/ymlLroi0sWq6lUwciGH5reEHsguTjbi0oAqmyAZVV1HY0bHRhJQLZzCaH+Pv96GR8Dy/8hpnv7/e57IC5yuEIbD14T+7h9Yjyrm0HaDrgIWuY=
Received: by 10.142.212.19 with SMTP id k19mr1659251wfg.1191503445867;
        Thu, 04 Oct 2007 06:10:45 -0700 (PDT)
Received: by 10.143.43.21 with HTTP; Thu, 4 Oct 2007 06:10:45 -0700 (PDT)
In-Reply-To: <20071004125641.GE15339@genesis.frugalware.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59948>

On 10/4/07, Miklos Vajna <vmiklos@frugalware.org> wrote:
> On Thu, Oct 04, 2007 at 02:27:41PM +0200, Paolo Ciarrocchi <paolo.cia=
rrocchi@gmail.com> wrote:
> > Why do we have the option "--cached" and not "--index"?
>
> according to glossary.txt, 'cache' is an obsolete for 'index'. probab=
ly
> this is the reason
>
> probably cache.h will be never renamed to index.h, i don't know if di=
ff
> --cached will be ever renamed to diff --index

Believe me, for a GIT newbie git --cached is confusing.

That user started reading "A tutorial introduction to git (for version
1.5.1 or newer)",
after a cuple of minutes of reading he reached "Making changes" saw:

" You are now ready to commit. You can see what is about to be
committed using git-diff(1) with the =97cached option:

$ git diff --cached "

$ git diff --index sound a lof more consistent with the general documen=
tation.

Regards,
--=20
Paolo
http://paolo.ciarrocchi.googlepages.com/
http://ubuntista.blogspot.com
