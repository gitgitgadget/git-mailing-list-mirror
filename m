From: Patrick Doyle <wpdster@gmail.com>
Subject: git stash path/to/only/one/subdirectory
Date: Wed, 8 Dec 2010 09:15:51 -0500
Message-ID: <AANLkTim+sOeVfkAac1v-CsD5GG8Vj2VSjXn-9SSw+Hjb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 08 15:16:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQKoi-0004GW-Ms
	for gcvg-git-2@lo.gmane.org; Wed, 08 Dec 2010 15:16:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755034Ab0LHOQN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Dec 2010 09:16:13 -0500
Received: from mail-fx0-f43.google.com ([209.85.161.43]:57220 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753526Ab0LHOQM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Dec 2010 09:16:12 -0500
Received: by fxm18 with SMTP id 18so1110110fxm.2
        for <git@vger.kernel.org>; Wed, 08 Dec 2010 06:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type;
        bh=+Hh3y4A3u/ch+94l4OA8BRhQhFHL7vnqp969nBLeDz4=;
        b=Y65qXGWFmAim+ExzzxQkHx890O7huy+GJsSc3DhaeAGHpq/ZKhQ1eEbmRWbLsf+w78
         AQvXdS5PIR0ZKkSDURujgKXyvTfE/jB3DbdcWbanv4dKG+5WI9vZp+bPtaE1c2w8qIfs
         UjAgarB3q3P96XC4hkviHajfC3ddmCsLemCm0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=eiDfwL6YClwYxWAn2tYIkkA7W6rRByRgO++V3RSdtM53OD3WnPfm1Z+1FeNpzzykgq
         rbhImbSm0hyAtFYvMM8MqQfxUfTo9Oecvvi99whD1T+0DpjN+MzfjMhZc1KK15gFNj+/
         98/vaDAo1d9dMk5ULd0H/2GVTvmdGzDK63I+c=
Received: by 10.223.97.13 with SMTP id j13mr6279787fan.146.1291817771448; Wed,
 08 Dec 2010 06:16:11 -0800 (PST)
Received: by 10.223.107.131 with HTTP; Wed, 8 Dec 2010 06:15:51 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163194>

Looking at the man page for git-stash, it seems like I can do this
with the --patch option to git-stash, but I figured I'd ask the
questions anyway...

Is it possible to git-stash a single directory, while leaving the rest
of my working copy in the state it's in?

In my particular case (as of 9:00am this morning), I've realized that
I want to split my work into 2 separate commits; I'm not done with
either of them yet; and they are in completely separate directories
from each other.  I would like to do something like:

$ git stash --subdir-only dir1
edit/test stuff in dir2, possibly committing once or twice along the way
$ git commit dir2
go off and do other stuff for a while, and come back to the dir1 stuff
I was playing with
$ git stash pop
finish the dir1 work
$ git commit dir1

If this capability doesn't exist, I could try adding it... would other
folks see this as useful?

--wpd
