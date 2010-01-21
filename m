From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: problem cloning via http since v1.6.6-rc0
Date: Thu, 21 Jan 2010 09:36:59 +0800
Message-ID: <be6fef0d1001201736g9160306g51949a5f36d83e14@mail.gmail.com>
References: <20100121004756.GA18213@onerussian.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Yaroslav Halchenko <debian@onerussian.com>
X-From: git-owner@vger.kernel.org Thu Jan 21 02:37:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXlz0-0002rL-Cp
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jan 2010 02:37:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753719Ab0AUBhB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2010 20:37:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753723Ab0AUBhA
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 20:37:00 -0500
Received: from mail-iw0-f196.google.com ([209.85.223.196]:65295 "EHLO
	mail-iw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753650Ab0AUBhA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2010 20:37:00 -0500
Received: by iwn34 with SMTP id 34so4226671iwn.21
        for <git@vger.kernel.org>; Wed, 20 Jan 2010 17:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=vBO/+Idw5HeYiYgU6qCKQNnjy1WutHCb5dBaLZ4myzY=;
        b=FwnF1L6l8u30+Wbk4EhEnCneJPBXETL189jQmIlvNCxXFOV8nkqip6DF3WZ50e/XdO
         b0/K6r/fvTDGyXbPZocJQFO7SBqL0MCkg2uxXWFhk06Mm2ChQUxUtBaNjKBz3uzekEs2
         DjsiA4tvgdWqC5l6TGtr+2RWkzTLgTD4/anwg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=LFdrk9E2r8XP33h4WjA54KaaYH4jDTOLzWRAjDDCjtVkOieICjtRhhRrs93U7Vb0b1
         oGHzgCEH5DdkkUnYd5NYwf5GjXoTmmO73W5PM9Kz1FXtD37ji9Bg1YGDbUKutLqWo1A0
         4zbrhgjyuH7aKyrtbA3N3im84Dccw5cEIW+po=
Received: by 10.231.167.65 with SMTP id p1mr1316751iby.20.1264037819266; Wed, 
	20 Jan 2010 17:36:59 -0800 (PST)
In-Reply-To: <20100121004756.GA18213@onerussian.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137612>

On Thu, Jan 21, 2010 at 8:47 AM, Yaroslav Halchenko
<debian@onerussian.com> wrote:
> $> GIT_TRACE=2 ./git clone http://git.debian.org/git/pkg-exppsy/pymvpa.git
> trace: built-in: git 'clone' 'http://git.debian.org/git/pkg-exppsy/pymvpa.git'
> warning: templates not found /home/yoh/share/git-core/templates
> Initialized empty Git repository in /home/yoh/proj/misc/git/pymvpa/.git/
> trace: run_command: 'remote-curl' 'http://git.debian.org/git/pkg-exppsy/pymvpa.git' 'http://git.debian.org/git/pkg-exppsy/pymvpa.git'
> trace: exec: 'git' 'remote-curl' 'http://git.debian.org/git/pkg-exppsy/pymvpa.git' 'http://git.debian.org/git/pkg-exppsy/pymvpa.git'
> trace: exec: 'git-remote-curl' 'http://git.debian.org/git/pkg-exppsy/pymvpa.git' 'http://git.debian.org/git/pkg-exppsy/pymvpa.git'
> trace: run_command: 'git-remote-curl' 'http://git.debian.org/git/pkg-exppsy/pymvpa.git' 'http://git.debian.org/git/pkg-exppsy/pymvpa.git'
> fatal: http://git.debian.org/git/pkg-exppsy/pymvpa.git/info/refs?service=git-upload-pack not found: did you run git update-server-info on the server?

oh, and by the way, could you also run this again with GIT_CURL_VERBOSE=1?

-- 
Cheers,
Ray Chuan
