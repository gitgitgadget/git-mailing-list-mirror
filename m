From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: how to clone from github behindd a proxy?
Date: Thu, 21 Jan 2010 08:54:27 +0800
Message-ID: <be6fef0d1001201654s78ba4e95r59754dd2645f587@mail.gmail.com>
References: <loom.20100120T102323-689@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Tim Michelsen <timmichelsen@gmx-topmail.de>
X-From: git-owner@vger.kernel.org Thu Jan 21 02:01:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXlQi-00012n-VT
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jan 2010 02:01:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752813Ab0AUBBp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Jan 2010 20:01:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752582Ab0AUBBp
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 20:01:45 -0500
Received: from mail-iw0-f196.google.com ([209.85.223.196]:36331 "EHLO
	mail-iw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751771Ab0AUBBo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Jan 2010 20:01:44 -0500
X-Greylist: delayed 436 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Jan 2010 20:01:44 EST
Received: by iwn34 with SMTP id 34so4204686iwn.21
        for <git@vger.kernel.org>; Wed, 20 Jan 2010 17:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=vw9lA3sWma9hAkmGBFeTSN878xaBMZqZGlNOwZY7jXY=;
        b=nC7Ra5ZkEUszHAVyrKcFejcDtXpYXWDMGslWMEc1kgXsZCwVrw1xt1BDPbEux3ab5q
         Scj92FLEW+jLkGxhskbddoapcIhAmL53+ZEwAu70KhgPVurbq7+Bb4IzYl6MtmIdAiuu
         moEoLWhpPbOnzaLXh83EAoBiEmT0lQ8/83oNY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Vmmp+1U+y2OSRBfTY4lAa1RCnvqfgmsozS/sxCrW7jXAupKRhA8DJ07SltCQRapRUC
         XixNQkQg2ZExttn+rhn2kg0H0t53WUNkJiLi3CX4do/3/W0wDiUjIB/6aR1LU4V4JDJr
         rlBUwwIG51eZw2OpPFWYRkjBMuJu08YYxk+D4=
Received: by 10.231.153.69 with SMTP id j5mr1241196ibw.33.1264035267231; Wed, 
	20 Jan 2010 16:54:27 -0800 (PST)
In-Reply-To: <loom.20100120T102323-689@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137607>

Hi,

On Wed, Jan 20, 2010 at 5:29 PM, Tim Michelsen
<timmichelsen@gmx-topmail.de> wrote:
> git clone http://github.com/rwl/traitsbackendpyjamas
> Initialized empty Git repository in D:\sourcecode/traitsbackendpyjama=
s/.git/
> * Couldn't find host github.com in the _netrc file; using defaults
> * About to connect() to proxy proxy.example.com on port 8000 (#0)
> * =A0 Trying 149.233.100.7... * Connected to proxy.example.com (149.2=
33.100.7)
> port 8000 (#0)
> =A0GET http://github.com/rwl/traitsbackendpyjamas/info/refs HTTP/1.1
> User-Agent: git/1.6.5.1.1366.g8ed9
> Host: github.com
> Accept: */*
> Proxy-Connection: Keep-Alive
> Pragma: no-cache
>
> * The requested URL returned error: 404
> * Closing connection #0
> fatal: http://github.com/rwl/traitsbackendpyjamas/info/refs not found=
: did you
> run git update-server-info on the server?

this isn't a problem with your proxy - git connects to your proxy fine.

The problem is that the info/refs file isn't found at the repo URL you
specified.

I think for github repos, you need to put a ".git" behind the url, so
you should try cloning from

  http://github.com/rwl/traitsbackendpyjamas.git

instead.

--=20
Cheers,
Ray Chuan
