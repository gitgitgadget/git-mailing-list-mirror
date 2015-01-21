From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PULL] git-svn updates from Ramkumar
Date: Wed, 21 Jan 2015 12:47:36 -0500
Message-ID: <CALkWK0mtZ_w6ExL+GZX4q3gsFj3qVwb+V463nAFFuTabqzobmA@mail.gmail.com>
References: <20150115090703.GA12333@dcvr.yhbt.net> <xmqqr3uv7u7v.fsf@gitster.dls.corp.google.com>
 <20150115224652.GA25482@dcvr.yhbt.net> <xmqqtwzr4ofo.fsf@gitster.dls.corp.google.com>
 <CALkWK0kHQ-qhD3p0_VEhVrbD39yV=F5t2nQZ4D6RKP_gpg9tKA@mail.gmail.com>
 <20150116000802.GA8616@dcvr.yhbt.net> <CALkWK0kFngxd2uwHjAtov+9rUbo13OOoeAhmvbxxsz39hmMnaw@mail.gmail.com>
 <20150116003931.GA28184@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Jan 21 18:48:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDzO9-0005jU-JZ
	for gcvg-git-2@plane.gmane.org; Wed, 21 Jan 2015 18:48:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753238AbbAURsS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2015 12:48:18 -0500
Received: from mail-ig0-f179.google.com ([209.85.213.179]:53739 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752285AbbAURsQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2015 12:48:16 -0500
Received: by mail-ig0-f179.google.com with SMTP id l13so22935281iga.0
        for <git@vger.kernel.org>; Wed, 21 Jan 2015 09:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=62phCYIqublfuufkqUV0nD/jW1sYwCNewp9aq8ukz+k=;
        b=c20QaaBb5YWErKkntuBD8xYJsl8pgmyqdmjU8L55FuaQ6DJF8qgWawYic6da/Lk7fQ
         QU1cDjXXekuEa76MkQOU8edWsYfFQrNnvq67+LV3JkXqtd1ZbG6JP8J7Y91fqWQkN7oa
         4Poe8Q+9ATSbTlHYrK0MrV09UFNlV35hIqp7z3qeZWU8WJ6LLM3fb4fPyWjlYfVgE0mk
         HOrS4raUzhjkQtIWFGXg24Od/21TJA4kmtolFtk69OvcX+iwd/pTkC8UsggC2LkS5LIW
         lla77/0yT6V1FQeV9wQbpc6y+bRdnXbuu4cZPFexzaveBIxK87LoR/kVCbd9cwyh7tVY
         nSFg==
X-Received: by 10.50.176.196 with SMTP id ck4mr6215431igc.40.1421862496151;
 Wed, 21 Jan 2015 09:48:16 -0800 (PST)
Received: by 10.64.102.163 with HTTP; Wed, 21 Jan 2015 09:47:36 -0800 (PST)
In-Reply-To: <20150116003931.GA28184@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262735>

Eric Wong wrote:
> Adding it to GITPERLLIB should work...

I tried everything including replicating the commands in the brew
formula that does the Right thing:
https://github.com/Homebrew/homebrew/blob/master/Library/Formula/git.rb

I'm clearly missing something. Can someone on Darwin tell us the right
flags/ env variables?
