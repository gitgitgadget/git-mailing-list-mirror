From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Reference to a commit inside a commit message
Date: Mon, 28 Apr 2014 12:55:45 -0700
Message-ID: <20140428195544.GN9218@google.com>
References: <20140428183552.GA9709@workstation.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: enzodicicco@gmail.com
X-From: git-owner@vger.kernel.org Mon Apr 28 21:56:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Werek-0002Z1-O9
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 21:56:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932433AbaD1Tzx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 15:55:53 -0400
Received: from mail-pb0-f49.google.com ([209.85.160.49]:64454 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932263AbaD1Tzs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 15:55:48 -0400
Received: by mail-pb0-f49.google.com with SMTP id rr13so6146706pbb.8
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 12:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=+dV14ulTQfTTdcoCT0pOo1c6zv3ij3f9ugoFevj3ByM=;
        b=KluNpfw4fM705/jpiJKu4DdQkeou2MwRGkYfYKIBdQsCbYW4TskkR9UQcMHSu2a6Tg
         ewtvNora4GSP4wV+LccChcYBE9GaikivZ9wMyh0KUKhF0/iYCXIbruFbjussMGssqnDo
         9jvgEdeW3sP6t5oNvQDIMEgNoHNAgfRN7JCGpz/mOg9TX4y5uZO3njaZXoMoA/nQ0Agu
         U73AdL0g6ouF8fxCra7XGRZ+8syb/QHaPE3HovXjQHgIMjqalvQvJBEb94YSj9BlzCrz
         oJdFyO9qfhDHDgHB0sir5193K+EZm7wr4WqHh9plKPccWXQHEDrCdJ30c+9/is5FhLh/
         MptA==
X-Received: by 10.67.14.98 with SMTP id ff2mr27594950pad.101.1398714947787;
        Mon, 28 Apr 2014 12:55:47 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id sv10sm36774632pbc.74.2014.04.28.12.55.46
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 28 Apr 2014 12:55:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140428183552.GA9709@workstation.Belkin>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247428>

Hi,

enzodicicco@gmail.com wrote:

> Hi to all, I'm trying to figure out what is the best way (and if it
> exists) to link a message of a commit to another commit.
[...]
> Obviously I don't mean to put the raw Hash,

Why not?

See the output of

	git log --grep='In commit '

and

	git log --grep='In v'

in git.git or linux.git for some examples of current practice.

Curious,
Jonathan
