From: layer <layer@known.net>
Subject: Re: is there a way to reference the branch point?
Date: Wed, 03 Feb 2010 13:40:59 -0800
Message-ID: <8481.1265233259@relay.known.net>
References: <18219.1264804157@relay.known.net> <fabb9a1e1001291435p59599f62hd54cbca66d91c24b@mail.gmail.com>
Cc: git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 03 22:41:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcmyC-00069i-QH
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 22:41:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932904Ab0BCVlD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 16:41:03 -0500
Received: from relay.known.net ([173.13.135.57]:34241 "EHLO relay.known.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932826Ab0BCVlA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 16:41:00 -0500
Received: from localhost (127.0.0.1) by relay.known.net
    (Allegro Maild v1.2.21) id 000000079472; Wed, 3 Feb 2010 13:40:59 -0800
In-reply-to: <fabb9a1e1001291435p59599f62hd54cbca66d91c24b@mail.gmail.com>
Comments: In-reply-to Sverre Rabbelier <srabbelier@gmail.com>
   message dated "Fri, 29 Jan 2010 23:35:18 +0100."
X-Mailer: MH-E 8.2; nmh 1.3; GNU Emacs 23.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138904>

Sverre Rabbelier <srabbelier@gmail.com> wrote:

>> Heya,
>> 
>> On Fri, Jan 29, 2010 at 23:29, layer <layer@known.net> wrote:
>> > If I make a branch `foo' off master, commit a bunch of times, is there
>> > a way to reference the place on master from which I branched?
>> 
>> Depends, if you make a new branch from master, you can use 'git
>> merge-base', so:
>> 
>> $ # on master
>> $ git checkout -b foo-topic-branch
>> $ # work work
>> $ git commit
>> $ # work work
>> $ git commit
>> 
>> Now you want to know where you branches off from master:
>> 
>> $ git merge-base foo-topic-branch master
>> 
>> That will show you the commit you branches off from, even if master
>> has grown new commits since then.

That works, but what if I don't know it's off master?  Normally, a
human would, but what if this is a script I'm writing?

Thanks.

Kevin
