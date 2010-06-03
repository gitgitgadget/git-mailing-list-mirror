From: Eugene Sajine <euguess@gmail.com>
Subject: Aliasing with parameters doesn't seem to work properly in git 1.7.0.5
Date: Thu, 3 Jun 2010 10:52:39 -0400
Message-ID: <AANLkTilEZknW7m0n3y8SX5oAaZiUTorgqfX3jTB8mnDC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 03 16:52:49 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKBmq-0008F8-8D
	for gcvg-git-2@lo.gmane.org; Thu, 03 Jun 2010 16:52:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755404Ab0FCOwm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jun 2010 10:52:42 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:60135 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754419Ab0FCOwl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jun 2010 10:52:41 -0400
Received: by gwaa12 with SMTP id a12so116766gwa.19
        for <git@vger.kernel.org>; Thu, 03 Jun 2010 07:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=JPa91udcVgWOLY93Zgod2DcvilVnyWyytUhsn9UWYjc=;
        b=Hu8g2kSAuq/ajk85i1SI3K4RkFdllDeVM5ZjDXnrMabg4FuTMAjWxphtLl5+Dxh0xM
         x61rEEwc22Oo8PVC575cG76OtYyYImCNp34+gm9cic4IQ8Nbku6WylyeYdJuPMpsYhB8
         hG8l/Q6o1M+XctFOaAwz6rBlU7RXwVU10B1ig=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=oAYJeu2UgIzvsMZOmAIyN8UH5kBo/PoyjIUZ/2MvhzZjlNK1ztrJ3qwKEsdIViccNg
         fCxjb+tV00WmXXrR0IZbkToSYCixbTGyfvkg/GNjYjZF5zX5WFa5mIyoYRiBY+AGmdZL
         W348iF+D7F3BPxAF0SJWBNSbZ7sz50SQKXSbU=
Received: by 10.224.35.206 with SMTP id q14mr4896116qad.146.1275576759822; 
	Thu, 03 Jun 2010 07:52:39 -0700 (PDT)
Received: by 10.229.239.210 with HTTP; Thu, 3 Jun 2010 07:52:39 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148328>

Hi,

i'm trying to create an alias like this:

cln = !sh -c 'git clone git://server/"$1"'

the idea is to make a shortcut, so instead of command like this:

$git clone git://server/folder/repo.git

i can have something like this:

$git cln folder/repo.git

or even
$git cln folder/repo

if the alias is like this:
cln = !sh -c 'git clone git://server/"$1".git'

this doesn't work as it tries to initialize a repo called server.git
and then fails because "remote hang up unexpecedly"
is there something wrong in expansion of this alias or the alias
itself is not valid?

Any ideas?

Thanks,
Eugene
