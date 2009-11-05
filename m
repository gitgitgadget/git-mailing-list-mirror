From: John Tapsell <johnflux@gmail.com>
Subject: Re: Automatically remote prune
Date: Thu, 5 Nov 2009 10:41:26 +0900
Message-ID: <43d8ce650911041741w4b39d137ha2a1529a15256d27@mail.gmail.com>
References: <43d8ce650911040242l44bbf87dm35494e04ce9039aa@mail.gmail.com>
	 <7v639qi2un.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 05 02:41:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5rML-0001bC-0U
	for gcvg-git-2@lo.gmane.org; Thu, 05 Nov 2009 02:41:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753147AbZKEBla (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 20:41:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751499AbZKEBl3
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 20:41:29 -0500
Received: from mail-pz0-f188.google.com ([209.85.222.188]:56363 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752654AbZKEBl3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 20:41:29 -0500
Received: by pzk26 with SMTP id 26so5106783pzk.4
        for <git@vger.kernel.org>; Wed, 04 Nov 2009 17:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=6aQB/qSEzrLjBppr55fADHg+HmgRtlUgF0HtBWqbIBY=;
        b=XEY0t13gOuc2rHZA/4E99fRopz0FoxfzKKpHJoqTmQoPIJG8DL5EXKBdVLecCh14qJ
         0dnEC1rZLnBLIK+5nckuHfDodoT24NvT9vMUjb/SF6XKjywlSx7gKnebHQxFz14XWq+z
         NRL0LdZbtkpAvKNupgx8reBtXBlDvAcFcKO1E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=eeQNxVIVx8LBELHwjZzTpoaYzMf9f8gwDl7Yer3IES1rMtuNmRXatdxN/ysep2JWYA
         6HYUP77Z0tt9I/mY80C9YFzt8SLRTZ4MVRA9HwGeBzG9OOc9JQkbZqz5sCKVYI9psMYv
         TiR4m7wLvHk+jKsHmkrywWpx0NdGs7Rp5Gaik=
Received: by 10.114.248.35 with SMTP id v35mr3664801wah.9.1257385286247; Wed, 
	04 Nov 2009 17:41:26 -0800 (PST)
In-Reply-To: <7v639qi2un.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132187>

2009/11/5 Junio C Hamano <gitster@pobox.com>:
> John Tapsell <johnflux@gmail.com> writes:

> You could store necessary information somewhere else when you contacted
> the remote the last time, but we need to consider what the benefits are to
> give this information in the first place.

We already get all this information on a "git fetch", no?  And then
promptly discard it.  Surely when we do "git fetch" .  So I'm talking
about just not ignoring the information we get from git fetch, but
present that information to the user.

John
