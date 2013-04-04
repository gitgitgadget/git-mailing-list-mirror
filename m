From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Thu, 4 Apr 2013 11:58:39 -0700
Message-ID: <20130404185839.GN30308@google.com>
References: <1365100243-13676-1-git-send-email-artagnon@gmail.com>
 <20130404184730.GL30308@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 04 20:59:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNpNT-0007yA-2D
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 20:59:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763458Ab3DDS6p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 14:58:45 -0400
Received: from mail-pb0-f44.google.com ([209.85.160.44]:38858 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763369Ab3DDS6o (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 14:58:44 -0400
Received: by mail-pb0-f44.google.com with SMTP id wz12so1597939pbc.17
        for <git@vger.kernel.org>; Thu, 04 Apr 2013 11:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=e7kU4LMW7dqwMufalBpSleSb2QnkQcWy2xR6sVtNg9g=;
        b=w/45KJE4spbe82C55XX52lkHze5QrvbP8/GR3cookH8Q0DIDviQgTlNPyqgeCc4Aht
         pb2dxZRP0qQ6wkVGQGOMcSwmBissRWeOjbwggT00/vbotX7aATUNNdKAVV9MBs8BJPvL
         9fbpKrwUtF0VWfvUX5MHClYwyad8V+2MXg5RdJw9sKkI88zGnmubW/uQVchEmHa6h/ch
         kcyzEMF5pwJUBWdiGFOMZ5x9hh8NgRYJdNM2LXTM7GXVPl6CtUARnQVfvm8eNo/H7F2j
         5lFNlA542YfjCygbEkDQqvpZV+FML1r1fy2TWNs/0k/ow1zM1BnOE2JAA6vfZ1L8d0JO
         ulQg==
X-Received: by 10.66.2.234 with SMTP id 10mr5523515pax.180.1365101924139;
        Thu, 04 Apr 2013 11:58:44 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id qh4sm12521927pac.8.2013.04.04.11.58.42
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 04 Apr 2013 11:58:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130404184730.GL30308@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220065>

Jonathan Nieder wrote:
> Ramkumar Ramachandra wrote:

>> The purpose of this series is to convince you that we've made a lot of
>> fundamental mistakes while designing submodules, and
[...]
> Shouldn't it be possible to explain the same thing using a test
> script illustrating intended UI?

Sorry, I sent this reply too quickly.  Your explanation to Linus
clarified the idea.

Regards,
Jonathan
