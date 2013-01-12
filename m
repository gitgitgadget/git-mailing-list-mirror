From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] cvsimport: rewrite to use cvsps 3.x to fix major bugs
Date: Sat, 12 Jan 2013 10:16:33 -0800
Message-ID: <20130112181633.GB4624@elie.Belkin>
References: <1357875152-19899-1-git-send-email-gitster@pobox.com>
 <50F17DB0.2050802@alum.mit.edu>
 <20130112161105.GB3270@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Chris Rorvick <chris@rorvick.com>
To: "Eric S. Raymond" <esr@thyrsus.com>
X-From: git-owner@vger.kernel.org Sat Jan 12 19:17:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tu5dc-0002BS-Ad
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jan 2013 19:17:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753920Ab3ALSQk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2013 13:16:40 -0500
Received: from mail-da0-f52.google.com ([209.85.210.52]:38192 "EHLO
	mail-da0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751797Ab3ALSQj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2013 13:16:39 -0500
Received: by mail-da0-f52.google.com with SMTP id f10so1226275dak.25
        for <git@vger.kernel.org>; Sat, 12 Jan 2013 10:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=AF1B9Io7jUJ3Yx/5EC54YwwQA5QMQ3gyXpKIpDfx2eY=;
        b=zaGb0AMmTR4Q36OIzD8LAr0gDzFIzWVu26AapO69w0qKaFc1WqV1NmZjg1wW7mw9ZJ
         y1jJm18rUbU/o4HdRIgJlQaV9dqXMKiWuRvkVPhsc327U7/S3wLPMQsH6AjpQpRfT9kc
         318WfIbED6nPUYm6qrBAO0trNt4iaNwNjyLkXUtRiATjALQfEJLc48DeV0A0kqgiLtna
         N2lRuJWKoYsCUr1yUyGikkap8FHWdu1QFs2K8lAVL8dBN57GSeBkKN9st+RjSptQfDSN
         4n3PTsQB5zFzrp1DqvKGkuTx/f1XaSuVR2J2QOmTcY3mP7d7VDaYqjkAzbWAdLudXWJC
         kXKQ==
X-Received: by 10.66.90.72 with SMTP id bu8mr217695640pab.69.1358014599233;
        Sat, 12 Jan 2013 10:16:39 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id k4sm5361034paz.26.2013.01.12.10.16.36
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Jan 2013 10:16:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20130112161105.GB3270@thyrsus.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213297>

Hi Eric,

Eric S. Raymond wrote:

>             But in practice the git crew was going to lose that
> capability anyway simply because the new wrapper will support three
> engines rather than just one.  It's not practical for the git tests to
> handle that many variant external dependencies.

See the git-blame/git-annotate tests for an example of how the
testsuite handles "variations on a theme".

It works fine.

Hope that helps,
Jonathan
