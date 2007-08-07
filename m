From: "Mark Levedahl" <mlevedahl@gmail.com>
Subject: Re: git on Cygwin: Not a valid object name HEAD
Date: Tue, 7 Aug 2007 13:42:56 -0400
Message-ID: <30e4a070708071042g5623cb7ak724a8b8e588bd1da@mail.gmail.com>
References: <f99cem$4a4$1@sea.gmane.org>
	 <Pine.LNX.4.64.0708071257350.14781@racer.site>
	 <f99nm6$9vi$1@sea.gmane.org> <f99rei$ou$1@sea.gmane.org>
	 <20070807143616.GO9527@spearce.org> <20070807145825.GO21692@lavos.net>
	 <66DD7425-6073-4CA8-BF01-BF07213A4804@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Sebastian Schuberth" <sschuberth@gmail.com>,
	"Brian Downing" <bdowning@lavos.net>
To: "Steffen Prohaska" <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Tue Aug 07 19:43:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIT5B-0001J5-Vx
	for gcvg-git@gmane.org; Tue, 07 Aug 2007 19:43:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764214AbXHGRm6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Aug 2007 13:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763048AbXHGRm6
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Aug 2007 13:42:58 -0400
Received: from ik-out-1112.google.com ([66.249.90.176]:35991 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761541AbXHGRm5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2007 13:42:57 -0400
Received: by ik-out-1112.google.com with SMTP id b32so509853ika
        for <git@vger.kernel.org>; Tue, 07 Aug 2007 10:42:56 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oQcVBo4iTF1tP3ba0S+xLF29RgYIlDEcozaNjrcYKCp+9st8Ndb92/OLY2kltRvMw3HgJ+LQ8zSnOkzMvhkc9WmRgknVwqqxrE5CqcUqiByL72ZrFcZ+T92D6AAV9mpIPrh+t3DcPm3D0bnqHaBkR2zd5FXI/hV4VUfhXKRsD4Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MBr3fbuTgM1yq5ytcXjhxcvZaDoPfM10OE2M/sWVsPWjkomo5u6nlulpEFVSoWxeb/iJIl60jArj/0M5KpCG6H7wVG0rHCb7s1y21xeBxtWCaiUk8ZBcj9xqcpU8dj3lfolu9DVsPDyfZOVYrWFmpzXjB2yEAeEEDLOaliqxkfM=
Received: by 10.78.166.7 with SMTP id o7mr1887116hue.1186508576116;
        Tue, 07 Aug 2007 10:42:56 -0700 (PDT)
Received: by 10.78.190.5 with HTTP; Tue, 7 Aug 2007 10:42:56 -0700 (PDT)
In-Reply-To: <66DD7425-6073-4CA8-BF01-BF07213A4804@zib.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55270>

On 8/7/07, Steffen Prohaska <prohaska@zib.de> wrote:
>
> My question is, is there any chance to handle the shell
> activity by setting the right CYGWIN options?
>

See my other message: text mounts are best considered obsolescent if
not deprecated, and that mode is definitely not actively developed.
There are just too many loopholes with forks and pipes to reliably "do
the right thing."

Your suggested tests for non-binary mode mounts (properly #ifdef'd for
Cygwin, possibly only enabled if specifically configured in) are a
reasonable idea.

Mark
