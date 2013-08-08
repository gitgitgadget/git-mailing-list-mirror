From: Justin Collum <jcollum@gmail.com>
Subject: Re: git status resets permissions on index file -- Ubuntu 12.04 64b
Date: Thu, 8 Aug 2013 15:33:32 -0700
Message-ID: <CACO0oR7M90iyDCo-mwoHn21jKRGuMsRWEeWkFXC-MCSUBscC9w@mail.gmail.com>
References: <CACO0oR7a1-fUASQ+SJVbH1CU8d=NbHrK0MuMu+9Pr4_=7q85Vw@mail.gmail.com>
	<52040F27.4050908@googlemail.com>
	<20130808221807.GA8518@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Stefan Beller <stefanbeller@googlemail.com>,
	Justin Collum <jcollum@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 09 00:33:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7Ym1-0005uz-Bc
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 00:33:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966781Ab3HHWdd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Aug 2013 18:33:33 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:33918 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965419Ab3HHWdd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Aug 2013 18:33:33 -0400
Received: by mail-ie0-f170.google.com with SMTP id e14so3046955iej.29
        for <git@vger.kernel.org>; Thu, 08 Aug 2013 15:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=W/WFhlB1qlmFIBD28lbAqh3SuQU+zE1ZVrbh24tQd6U=;
        b=OS4W+JBXfNclqXLKDQfP2Cufi1yjbj2QYZhmoggg8nKi4IO02Cxa8ECUQD/Ou5VP61
         HOvjDV3dVSsX6Grw6xZHW22Rhm6yX9w6qAblo5Sbe0JQyAxF2TWh70qPGva9Wo1HdT9U
         UqA+wa7G491+aHbe8kzodTVJ4B/d6fmU5U2l2URhJTk6+CX7AiX4l4LVJ7l3O9HDjw4A
         x6ovWOvXT2sbX+4O630GiO8FHWR+TaYfkXcl192guSJCZvqFdQvjxWiiIrUdsbwUtrF0
         O+L8HN4w1xbF2rBFeIe0W3mszHFpUSh7lPWwk0DXcVGTHO+Zyu+X+woZD75yWbaARlV7
         /QOA==
X-Received: by 10.43.9.4 with SMTP id ou4mr3245967icb.53.1376001212521; Thu,
 08 Aug 2013 15:33:32 -0700 (PDT)
Received: by 10.43.146.70 with HTTP; Thu, 8 Aug 2013 15:33:32 -0700 (PDT)
In-Reply-To: <20130808221807.GA8518@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231947>

On Thu, Aug 8, 2013 at 3:18 PM, Andrew Ruder <andy@aeruder.net> wrote:
> he is neither the user dev or the group dev

I am both. There's only one user on this machine and he is me.

> he is regularly running  chmod -R 777

Yes, true. I have a program that I use to edit some of these files
(not the git files) that likes to screw up permissions. It's a long
story. Anyway, I've been running that chmod regularly since well
before this git issue started. I'll start using 644 for the chmod and
see if that helps.
