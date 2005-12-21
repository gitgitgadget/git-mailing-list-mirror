From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Pushing git patches to a subversion project
Date: Wed, 21 Dec 2005 18:37:26 +1300
Message-ID: <46a038f90512202137w772a3fe9p8e9e68345e39654a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Wed Dec 21 06:40:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EowgX-00025E-9O
	for gcvg-git@gmane.org; Wed, 21 Dec 2005 06:38:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128AbVLUFh2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Dec 2005 00:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932129AbVLUFh2
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Dec 2005 00:37:28 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:24157 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932128AbVLUFh1 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2005 00:37:27 -0500
Received: by wproxy.gmail.com with SMTP id 57so61999wri
        for <git@vger.kernel.org>; Tue, 20 Dec 2005 21:37:26 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=d5ermuRblNjgz3lrEhelLrNtiKUPkI26z573CcGqKEK5Cale5E0HJztVKyGhQpO741vWhlS0EZ0fQn4tS1bFt4uDuLQ4TRcz7QZ/+GDELPK6ADt4mgWzgOLcgJ8cdX5BNkmkbm8fvhlUuxa0U2bAlt8JVI3e1i5TzGPNCNoUzV8=
Received: by 10.54.123.3 with SMTP id v3mr460183wrc;
        Tue, 20 Dec 2005 21:37:26 -0800 (PST)
Received: by 10.54.72.15 with HTTP; Tue, 20 Dec 2005 21:37:26 -0800 (PST)
To: Git Mailing List <git@vger.kernel.org>,
	Matthias Urlichs <smurf@smurf.noris.de>,
	Kalle Valo <Kalle.Valo@iki.fi>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13869>

I am starting to work an svn-based upstream. In order to make life
easy for me and for them I am trying to figure out a way for them to
be able to merge my (emailed) patches atomically and preserving my
comments.

Something like git-am for svn.

Ideally, it should keep the patch as free of corruption as possible,
as the results will be echoed back into my branches via git-svnimport
and later "cg-update upstream" and I want git-cherry to have a fair go
at matching them.

There doesn't seem to be much. SVN-based projects ask for unified
diffs mostly, and I can't find indication of patch trading that
includes commit messages.

Any hints?

cheers,


martin
