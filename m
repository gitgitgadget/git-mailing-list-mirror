From: Richard Hansen <rhansen@bbn.com>
Subject: Re: Pull is Mostly Evil
Date: Mon, 05 May 2014 11:39:02 -0400
Message-ID: <5367B096.80700@bbn.com>
References: <5363BB9F.40102@xiplink.com>	<xmqqoazgaw0y.fsf@gitster.dls.corp.google.com> <CAEBDL5USVuFDXQk7Cb9cJ8Lm4RJNeJB0DwZBCB1cXmkroD8w3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Git Mailing List <git@vger.kernel.org>
To: John Szakmeister <john@szakmeister.net>
X-From: git-owner@vger.kernel.org Tue May 06 19:06:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Whi3v-0006KZ-FF
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:17:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753707AbaEEPjH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2014 11:39:07 -0400
Received: from smtp.bbn.com ([128.33.0.80]:27693 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751027AbaEEPjG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2014 11:39:06 -0400
Received: from socket.bbn.com ([192.1.120.102]:41513)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1WhKyt-000MbJ-Ck; Mon, 05 May 2014 11:39:03 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id DD6A83FF81
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <CAEBDL5USVuFDXQk7Cb9cJ8Lm4RJNeJB0DwZBCB1cXmkroD8w3g@mail.gmail.com>
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248172>

On 2014-05-03 06:00, John Szakmeister wrote:
> FWIW, at my company, we took another approach.  We introduced a `git
> ffwd` command that fetches from all remotes, and fast-forwards all
> your local branches that are tracking a remote, and everyone on the
> team uses it all the time.  It should be said this team also likes to
> use Git bare-metal, because they like knowing how things work
> out-of-the-box.  But they all use the command because it's so
> convenient.

I also wrote a script to fast-forward all local branches to their
configured upstream refs.  I finally got around to uploading it
somewhere public:

   https://github.com/richardhansen/git-update-branch

I use it in my 'git up' alias:

   git config --global alias.up \
       '!git remote update -p; git update-branch -a'

If there's interest I can tweak the style to conform to
Documentation/CodingGuidelines and stick it in contrib/ or something.

-Richard
