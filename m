From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Another way to compare tools: is it possible to transfer full history?
Date: Tue, 28 Sep 2010 15:48:07 -0500
Message-ID: <AANLkTi=oRv4NnG0yWCpmj+AVXijGU-EK5rAHUZ4dZLQV@mail.gmail.com>
References: <loom.20100928T153519-936@post.gmane.org>
	<4CA20169.2040606@dbservice.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Tuomo <tuo.tie@gmail.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Rocco Rutte <pdmef@gmx.net>,
	David Barr <david.barr@cordelta.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Tomas Carnecky <tom@dbservice.com>
X-From: git-owner@vger.kernel.org Tue Sep 28 22:48:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0h69-0007Fd-5A
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 22:48:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752131Ab0I1UsL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Sep 2010 16:48:11 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:49700 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751361Ab0I1UsK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Sep 2010 16:48:10 -0400
Received: by gxk9 with SMTP id 9so33014gxk.19
        for <git@vger.kernel.org>; Tue, 28 Sep 2010 13:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=rEDWWG7ImtG19dRQvnU00K1quEqHhtKYaobGRwWwhYM=;
        b=ZV60+x1jJnF4yZAZHhVqPePUla5HWuS5HyilEtQm1FnzeNVDRFL7l04hIDTUs8MXUh
         X2lryL+jIRz39n+NPLISe/RnaoIcr6H6HRhfjuuDAoBpI89eCpfzi5SDu1UrG7ENROdH
         LHpC27OZ66aM95OzKYJWfxbagmGgL2TzwIW/Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=SjLfA2IhQL35Y5O+6Q4BirVolQivYk305vApDpNC3C+TviZ+wa3JhSCMAM6TnsiuNO
         3+6lTeedaaVfiquexAyIkDk4ZeSlNKQp6DJ/NKLR81w9bGRlzwABlqh3z225XQNCeVhs
         PpGjUDZ8WjgKqFFzuh13VcaAP+M0SCcfo8LVE=
Received: by 10.231.173.3 with SMTP id n3mr557801ibz.56.1285706887302; Tue, 28
 Sep 2010 13:48:07 -0700 (PDT)
Received: by 10.231.11.65 with HTTP; Tue, 28 Sep 2010 13:48:07 -0700 (PDT)
In-Reply-To: <4CA20169.2040606@dbservice.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157467>

Tomas Carnecky wrote:

> (shameless plug: just this weekend I started collecting the various fast
> import/export tools and made a webpage about it:
> http://caurea.org/fast-export-import/.

This is awesome --- thank you!

In development:

svn-fe (contrib/svn-fe in Git) converts from an svn dump file to a
fast-import stream. Stale webpage:
http://barrbrain.github.com/svn-dump-fast-export/

remote-hg (see git_remote_helpers/hg/ in
http://github.com/SRabbelier/git) contains a partial hg fast-export
implementation in exporter.py. I don't know how it compares to Rocco
Rutte's exporter.

Not sure if these belong on your list yet, but thought you might like
to know about them. :)
