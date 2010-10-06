From: Eric Raible <raible@gmail.com>
Subject: Re: git push <branch-name>
Date: Tue, 5 Oct 2010 17:52:26 -0700
Message-ID: <AANLkTi=k9aEqpvoEvU5f-t-63==fouFmJ+OxO=6sQd89@mail.gmail.com>
References: <AANLkTineD3DYsBJBBt13-EWX0_1YUf1cf1wTGUL-jRkg@mail.gmail.com>
	<AANLkTinjEoDWhq_EWPj+z++g-b7XMA9d2orXRGtuHyRB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 06 02:52:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3IFL-0001wJ-R8
	for gcvg-git-2@lo.gmane.org; Wed, 06 Oct 2010 02:52:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758187Ab0JFAw2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Oct 2010 20:52:28 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:40581 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758181Ab0JFAw1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Oct 2010 20:52:27 -0400
Received: by qyk10 with SMTP id 10so3394432qyk.19
        for <git@vger.kernel.org>; Tue, 05 Oct 2010 17:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=Qq9zBd7X+4az5tsuQ1O3xXGDYQ4zRh8QFhr7Tddq73k=;
        b=n3o7EFM8D2qOjcbq27n74Z0pIiRjQKuy5Vm/OHFu/pc6EBo9qeAv6qEGXH7P+QMEa2
         mBPt4VCcmmRJT/B+FPT3+OZJEwgIByDvaafAXCIL9VP46pG83FqtEkQcEZUcfEGC9mMg
         N2mxyFHDXC81uluLOpqg4hMQ0gahQAkCB1G1o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=w0RJdAXac95ffSuwirQVYKg5hhnR7wgvceZkZllOjYkvYIlbv8np6XHnwnkOCKWL+V
         CQnzCgRadjlckqCl+MO8VqsaByDnDZMtVKQyOjEa7mkoFv6PYUr/RKRCrK+pfjMZ6OBz
         2Auwj931ah3ECHJl8owmJx7JtOtGgYSQ+YWE8=
Received: by 10.224.11.141 with SMTP id t13mr8795474qat.307.1286326346163;
 Tue, 05 Oct 2010 17:52:26 -0700 (PDT)
Received: by 10.220.163.85 with HTTP; Tue, 5 Oct 2010 17:52:26 -0700 (PDT)
In-Reply-To: <AANLkTinjEoDWhq_EWPj+z++g-b7XMA9d2orXRGtuHyRB@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158260>

On Tue, Oct 5, 2010 at 3:35 PM, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> Since it is such a simple command expansion, why not create an alias
> that does just that?

Because I don't want an alias, I want to extend git-push.

According to the man page, "git push"

"Works like git push <remote>, where <remote> is the current branch's remote
 (or origin, if no remote is configured for the current branch)."

What I'm advocating is that "git push <branch>" would be described with:

"Works like git push <remote> <branch>, where <remote> is the <branch>'s remote
 (or origin, if no remote is configured for <branch>)."
