From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: What's cooking in git.git (Nov 2009, #06; Wed, 25)
Date: Thu, 26 Nov 2009 02:15:58 +0100
Message-ID: <fabb9a1e0911251715u661ce0aem79a4d700d552e105@mail.gmail.com>
References: <7v8wduksgq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Nov 26 02:16:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDSy8-0002dJ-2v
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 02:16:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758889AbZKZBQN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Nov 2009 20:16:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758853AbZKZBQM
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 20:16:12 -0500
Received: from mail-vw0-f192.google.com ([209.85.212.192]:55823 "EHLO
	mail-vw0-f192.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755265AbZKZBQM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Nov 2009 20:16:12 -0500
Received: by vws30 with SMTP id 30so76931vws.33
        for <git@vger.kernel.org>; Wed, 25 Nov 2009 17:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=+UOwcOFi7m2oDbMo5jTRu6yPtRk5ymksq5nh8xnIM8I=;
        b=fuWSHJqrIsTE8Lno8qa6nbysCItuvtrnkNF4OZBbF9w8u86O+Cj4EyFDYSreP42h+B
         b4HlYv56HeLyWX8o0BcG9HLkolYxIwfQ8xFjcFQVRTICg4ej+L1JK+9Pq13EasxybIZz
         APK28KVpB+peXSGYYdkQ8WEqVrECMof/v64nE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=rLGioZBzY6aTy9LYR+wdGzWR5sgUmakJMOYeDLzn2yknJv5Yo3LXJpVAWAWGOGI3id
         JlF0DWdlkWA/P2FeNVKcf8YDRUu6ZWKMpysAMua2Pm0Y8cpHNZMHvJqkA5IPR6z/9Is9
         /zA6gAvLYNUBh7xEX/D8jAa8DLJsucCL0DkjM=
Received: by 10.220.3.211 with SMTP id 19mr10248170vco.7.1259198178242; Wed, 
	25 Nov 2009 17:16:18 -0800 (PST)
In-Reply-To: <7v8wduksgq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133750>

Heya,

On Thu, Nov 26, 2009 at 02:03, Junio C Hamano <gitster@pobox.com> wrote=
:
> * sr/vcs-helper (2009-11-18) 12 commits
> =A0- Add Python support library for remote helpers
> =A0- Basic build infrastructure for Python scripts
> =A0- Allow helpers to report in "list" command that the ref is unchan=
ged
> =A0- Fix various memory leaks in transport-helper.c
> =A0- Allow helper to map private ref names into normal names
> =A0- Add support for "import" helper command
> =A0- Allow specifying the remote helper in the url
> =A0- Add a config option for remotes to specify a foreign vcs
> =A0- Allow fetch to modify refs
> =A0- Use a function to determine whether a remote is valid
> =A0- Allow programs to not depend on remotes having urls
> =A0- Fix memory leak in helper method for disconnect
>
> Replaced again, and looking good. =A0Perhaps Daniel has some comments=
?

Indeed, Johan, Daniel, is the current version good for next?

--=20
Cheers,

Sverre Rabbelier
