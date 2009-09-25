From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: How does gitosis know who the key belongs to
Date: Fri, 25 Sep 2009 17:31:58 +0530
Message-ID: <2e24e5b90909250501m3ba1a1f3kc83ba66db8dfb489@mail.gmail.com>
References: <26ae428a0909240751k3a799750h121935a79439b389@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Howard Miller <howard@e-learndesign.co.uk>
X-From: git-owner@vger.kernel.org Fri Sep 25 14:02:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mr9V4-0000DX-Fp
	for gcvg-git-2@lo.gmane.org; Fri, 25 Sep 2009 14:02:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752426AbZIYMB4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Sep 2009 08:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752374AbZIYMBz
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Sep 2009 08:01:55 -0400
Received: from mail-iw0-f178.google.com ([209.85.223.178]:41524 "EHLO
	mail-iw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751069AbZIYMBz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Sep 2009 08:01:55 -0400
Received: by iwn8 with SMTP id 8so1498116iwn.33
        for <git@vger.kernel.org>; Fri, 25 Sep 2009 05:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=//ql7yQqZnI26bpT5avmFylGTmR42qdB2wv8orQ36es=;
        b=fDEgHMl7YgzYe5CSpssKfeNN9n2CgupMsG8N9AH5Baggh5YoTvzGm5lN5YEf6jpmlh
         mYXjgehux/sSnCpU84piIJbA6q1q/lZ1xeYEYmiRob4COiEJsqxZwmjUURc9smsxcg9H
         BHsNu3mv3wfbC7k4wt+8eW/+yYqiF+jiZUCeg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=owlvcuc7fVDAOVV6bpdkaCQQnG4Z41frYaLXYJ6A1nr3pNulXmtE8wPbqkOv30OjvC
         1Qn+fBJoaIJ8skKNZLvPEmo4hOj9p5C1xQW6ox2kyDFrQfImM36Ln9vW3m9W+0l/qkqi
         FgLS7kRn1T+Qm9M+xdNzyGoEK58OFQnCQlMTE=
Received: by 10.231.6.87 with SMTP id 23mr132321iby.19.1253880118795; Fri, 25 
	Sep 2009 05:01:58 -0700 (PDT)
In-Reply-To: <26ae428a0909240751k3a799750h121935a79439b389@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129078>

On Thu, Sep 24, 2009 at 8:21 PM, Howard Miller
<howard@e-learndesign.co.uk> wrote:
> Hi,
>
> This is probably another one of my stupid questions.
>
> Gitosis obviously uses keypairs but the config file addresses the user
> by name/host. How does gitosis connect the two together? Is it any
> more complicated than the user detail at the end of the public key?
>
> The second part of my question then is is it possible to use the same
> private key on more than one host?

Everything you ever wanted to know about how gitosis and ssh work
together: http://sitaramc.github.com/0-installing/9-gitosis-server-install.html

Very verbose.  (I've even been told it is too verbose but I chose to
ignore him ;-)

-- 
Sitaram
