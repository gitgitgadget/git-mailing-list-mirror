From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git wish page
Date: Fri, 27 Apr 2007 16:50:27 +0200
Message-ID: <200704271650.27923.jnareb@gmail.com>
References: <f36b08ee0704251505r226a8011h180ec6a8fb4ba5b7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Yakov Lerner" <iler.ml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 27 16:46:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhRik-0003rt-Oi
	for gcvg-git@gmane.org; Fri, 27 Apr 2007 16:46:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755913AbXD0Oqg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Apr 2007 10:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755904AbXD0Oqf
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Apr 2007 10:46:35 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:2139 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755914AbXD0Oqd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2007 10:46:33 -0400
Received: by ug-out-1314.google.com with SMTP id 44so830809uga
        for <git@vger.kernel.org>; Fri, 27 Apr 2007 07:46:32 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-disposition:cc:content-type:content-transfer-encoding:message-id;
        b=ZViWwaoRrTvs13KTodzQ+c7OGZ6bLsJBnVKg73WtG/8KG8ad86x+bgbl2igcQGf8+KnP3OQJCJX7yFlEu3sZMyyUDeECrCG4cZE5O3t8Ur3Xu8vH57uphcbtYtOng/EZ0cNQZzpq121KFhKz6q/3/FX1PN+TxU8/DRwER2YuVo0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-disposition:cc:content-type:content-transfer-encoding:message-id;
        b=nkl25UAGhZnm0SxILjRBE5uZpyGWhfzAgTlQ7ENpqmeO9EH/Ea+LyE82zIyqWIfJcETSdQuKQZGH3Q9NVwiwywOo7qsn4xR2MoTiv2ivJf85+VHTkWS//YF/n6y1IXGA1tAp+QBxTntW5SKZMqiP9KIup89r1G7oAsa49EAp0QQ=
Received: by 10.66.216.6 with SMTP id o6mr3050831ugg.1177685192535;
        Fri, 27 Apr 2007 07:46:32 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id x26sm5589638ugc.2007.04.27.07.46.30;
        Fri, 27 Apr 2007 07:46:31 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <f36b08ee0704251505r226a8011h180ec6a8fb4ba5b7@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45721>

On Thursday, 26 April 2007, Yakov Lerner wrote:

> I'd like have a wish added ("support empty directories") to the
>           http://git.or.cz/gitwiki/Wishlist
> git wish page.

First of all, from the http://git.or.cz/gitwiki/GitFaq

 Q. Can I add empty directories?

 A. No, git only cares about files, or rather git tracks content and
    empty directories have no content.

    Directories are added automatically when adding files inside them.
    That is, directories never have to be added to the repository, and
    are not tracked on their own.

    Though you can say "git add <dir>" and it will add files in there.

    If you really need a directory to exist in checkouts, you should
    create a file in it. .gitignore works well for this purpose; you can
    leave it empty, or fill in the names of files you expect to show up
    in the directory.

> What do I need to have it added? 
> 
> Do I just wiki-edit this page and add a wish?

That is idea of wiki, that anybody can easily edit page.

> Or I email the maintainer of the wiki site ? J.Hamano told me to
> talk to the "maintainer". I think you are maintainer, no ?

There was some talk about having TODO / Wishlist maintainer on git 
mailing list; somebody who would watch git mailing list (or read 
archives), and optionally #git IRC channel on FreeNode (or browse 
archives), add entries to it, and remove implemented (or move to 
"Granted wishes" section).  Currently there is no such person; I am
not Wishlist wiki page maintainer.

The http://git.or.cz/gitwiki/Wishlist page was created by Andy Parkins, 
with some items tongue-in-cheek.

IIRC the admin of GitWiki is Petr "Pasky" Baudis; he has admin 
privileges like ability to delete a page, or rename a page, or add 
extension to MoinMoin wiki engine.  But he doesn't do much (besides 
providing us with the GitWiki; thanks a lot, pasky), certainly
he do not maintain, nor watch, any wiki page.

I have sent from time to time "[RFC] gitweb wishlist and TODO list"
message to git mailing list, to ask for ideas to implement, and which 
ideas implement first.

-- 
Jakub Narebski
Poland
