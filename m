From: Mircea Bardac <dev@mircea.bardac.net>
Subject: Re: git blame for a commit
Date: Mon, 23 Jun 2008 10:04:16 +0100
Message-ID: <485F6710.1080300@mircea.bardac.net>
References: <485ED2E5.3070906@mircea.bardac.net> <alpine.LFD.1.10.0806222300410.23258@sys-0.hiltweb.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ian Hilt <Ian.Hilt@gmx.com>
X-From: git-owner@vger.kernel.org Mon Jun 23 11:11:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAi4y-0002Ng-Fj
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 11:11:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755734AbYFWJKE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 05:10:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755615AbYFWJKD
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 05:10:03 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:23183 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754691AbYFWJKA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 05:10:00 -0400
Received: by yw-out-2324.google.com with SMTP id 9so864865ywe.1
        for <git@vger.kernel.org>; Mon, 23 Jun 2008 02:09:54 -0700 (PDT)
Received: by 10.142.52.18 with SMTP id z18mr3360667wfz.295.1214212185902;
        Mon, 23 Jun 2008 02:09:45 -0700 (PDT)
Received: from ?192.168.126.97? ( [212.13.49.167])
        by mx.google.com with ESMTPS id h36sm24030668wxd.28.2008.06.23.02.09.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 23 Jun 2008 02:09:44 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080502)
In-Reply-To: <alpine.LFD.1.10.0806222300410.23258@sys-0.hiltweb.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85847>

Ian Hilt wrote:
> On Sun, 22 Jun 2008 at 11:32pm +0100, Mircea Bardac wrote:
>> Is there any straightforward way of doing git blame for all the files that got
>> changed in a commit. Problems are renames, deletes and copies.
> 
> Sounds like you want to track files rather than content.  Git tracks the
> latter.

Hmm... I'm not really sure that my initial intention was to track files. 
I've given this some more thought and I realized that what I actually 
want is a "git diff" with blame info included. I want this information 
in order to facilitate code reviewing.

It is true that this would be a front-end functionality, but I am not 
sure at the moment what the best approach would be for something like 
this. I would see this something like
$ git diff --blame[="parameters_for_blame"] commit1..commit2
but this is just a thought.

Has anyone tried blaming a "git diff"?

Many thanks.

--
Mircea
http://mircea.bardac.net
