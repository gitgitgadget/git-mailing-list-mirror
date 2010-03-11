From: Chris Packham <judge.packham@gmail.com>
Subject: Re: re-running merge on a single file
Date: Thu, 11 Mar 2010 11:09:16 -0800
Message-ID: <a038bef51003111109w2b4feaeeg120383a0645a0a7@mail.gmail.com>
References: <a038bef51003111054n5bcecd2eud531dcc80509f952@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 11 20:09:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Npnl6-00010F-0f
	for gcvg-git-2@lo.gmane.org; Thu, 11 Mar 2010 20:09:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755499Ab0CKTJT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Mar 2010 14:09:19 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:54403 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753439Ab0CKTJR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Mar 2010 14:09:17 -0500
Received: by pwi1 with SMTP id 1so194150pwi.19
        for <git@vger.kernel.org>; Thu, 11 Mar 2010 11:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type;
        bh=ytSGYz3xnIQqj1WBB6vQC/E9HT4Jk0KGKa9eV1L5f5E=;
        b=ZEvK6SA+KZvDP5ovTkHFGgeuDsJORDxLPniN7pyVLrhgNq+U6mYcQgf/79MlbubXsp
         p5RtYNIISt6DUqpLJso+H6qlobjBnhD1MZAwkGL3ixQfWYgLSjvvVQmWEfxaUVVGb2z6
         kK9EzqiDtLv98Pm92LRExXgj80o0a1+GF1GbM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=bjUrveeH9f4w0tZxIOtZu7/y15bZwC16jBlWb6dbOfV5K3aXT8ZmeZYppgRPN1DzNF
         nB5j+FD/PxRQBL1aOaYbmACLfRlip78CPPVzgfPL2VLdLu5/gd0lixJ28Gs2iPOEhcgk
         tQR8HS4HVrHsJy8mz2DK6C28yNjLKYaX86Us8=
Received: by 10.114.68.13 with SMTP id q13mr1504504waa.190.1268334556704; Thu, 
	11 Mar 2010 11:09:16 -0800 (PST)
In-Reply-To: <a038bef51003111054n5bcecd2eud531dcc80509f952@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141991>

Answering my own question.

On Thu, Mar 11, 2010 at 10:54 AM, Chris Packham <judge.packham@gmail.com> wrote:
> Alternatively I could manually drive and external merge tool like
> kdiff3 if I had a recipe for getting the common ancestor revision.
> Something like
>
> git checkout <magic pathspec> -- file
> mv file file.base

git checkout $(git merge-base master vendor) -- file

Still if anyone has a cleaner way of doing this I'd like to hear it.
It especially like a one-shot get file X from revision Y save as Z.
