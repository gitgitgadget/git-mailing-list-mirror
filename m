From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: qgit idea: interface for cherry-picking
Date: Tue, 4 Jul 2006 20:23:11 +0200
Message-ID: <e5bfff550607041123l485b3e1di7d9d36047934d59b@mail.gmail.com>
References: <e8954u$srh$1@sea.gmane.org>
	 <e5bfff550607021504l6e7fc8b8ja61f20f630c0f3f@mail.gmail.com>
	 <e89iql$42a$1@sea.gmane.org>
	 <e5bfff550607022245s2ef160fu5ad30a822f06117d@mail.gmail.com>
	 <7vzmfrrxyp.fsf@assigned-by-dhcp.cox.net>
	 <e5bfff550607030418n6a46c0cdh1a95155e1feb4356@mail.gmail.com>
	 <7vd5cmqwv3.fsf@assigned-by-dhcp.cox.net>
	 <e5bfff550607032322jdf3bc79l3f41c292ebb6d3f7@mail.gmail.com>
	 <7vk66tna71.fsf@assigned-by-dhcp.cox.net>
	 <e5bfff550607040421id4e71efw38ee2bd773c949de@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 04 20:23:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxpYN-0003wM-Ja
	for gcvg-git@gmane.org; Tue, 04 Jul 2006 20:23:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190AbWGDSXN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Jul 2006 14:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751179AbWGDSXN
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Jul 2006 14:23:13 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:31449 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751093AbWGDSXM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jul 2006 14:23:12 -0400
Received: by py-out-1112.google.com with SMTP id t32so1933553pyc
        for <git@vger.kernel.org>; Tue, 04 Jul 2006 11:23:11 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ty+eJUqtqjYMlKUCOlpMWJS9QP4U0DzaBYn+WDGUuw7gfkvMgaes1BFf3gvfrlny64jD8jGLzJyGVUSytO2jpAeiTZOMuta64KVg8NLm5T/2JQQJCzLSfGib/I5rIaPlEO3Wqs5s52WFnOgiVEzlYe/iWwExkzFruzYZ+jDpGLU=
Received: by 10.35.27.1 with SMTP id e1mr2438919pyj;
        Tue, 04 Jul 2006 11:23:11 -0700 (PDT)
Received: by 10.35.52.17 with HTTP; Tue, 4 Jul 2006 11:23:11 -0700 (PDT)
To: "Jakub Narebski" <jnareb@gmail.com>
In-Reply-To: <e5bfff550607040421id4e71efw38ee2bd773c949de@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23305>

On 7/4/06, Marco Costalba <mcostalba@gmail.com> wrote:
> On 7/4/06, Junio C Hamano <junkio@cox.net> wrote:
> > "Marco Costalba" <mcostalba@gmail.com> writes:
> >
>
> I have started to implement the feature suggested by Jakub (patch in
> working dir only, not committed).

Ok. I have pushed two patches, the first with support for applying a
patch series in working dir only, i.e. without  to create new commits,
the second to add "branch that a rev belongs to" info as in gitk, near
tags information was already there.

The difference with gitk is that only loaded branch/tags are
considered, this is to better scale.
Anyhow, due to little tricks ;-) , indexing is very fast, about 250ms
to index the whole Linux tree on my box.

    Marco
