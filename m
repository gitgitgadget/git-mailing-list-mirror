From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [Feature request] make git buildable from a separate directory
Date: Sat, 5 Jan 2013 16:49:17 -0800
Message-ID: <20130106004917.GA6063@elie.Belkin>
References: <50E89275.6080408@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Blake <eblake@redhat.com>
To: Manlio Perillo <manlio.perillo@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 06 01:49:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TreQv-0001v5-Tk
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 01:49:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754146Ab3AFAt0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2013 19:49:26 -0500
Received: from mail-pb0-f43.google.com ([209.85.160.43]:64963 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754098Ab3AFAtZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2013 19:49:25 -0500
Received: by mail-pb0-f43.google.com with SMTP id um15so9936876pbc.30
        for <git@vger.kernel.org>; Sat, 05 Jan 2013 16:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=ZjJi+S+AZVkmWUaH/SkCHLS+0UOJbkIERhU3rrJ2Ojg=;
        b=HQAGhEJ5pVJr7ECP/nOaGjIz6K6LhU9+fsg+hJUXCWXDly5xRkCFOIHNe+gOR2+jnK
         rcyo3r+saK1MaepK+smniKpZ604/xjiTfnPRwcyoCZ50mu2rXYxPQeAMW9Hutrj6YmAv
         iceShcWk+p9fsSXa8ZMSlENX4z9ZNER+mQO5mim7/eFcPqVGBSaJm62beffFPtMdMT4/
         MYczEVgH2LxtGz5x4iBu2Q1lmpz8NpdaGWKdGjGazFdxElQP1KhqbmLLiJD/i+FQYxl3
         qJA/5Gu0JeSjXLojUppYLCYWcMVrpjEzc6Q8gLAwE7+Z4YChdRgULkGT61Az9WcZBzWO
         kfBg==
X-Received: by 10.68.216.134 with SMTP id oq6mr174182335pbc.162.1357433364774;
        Sat, 05 Jan 2013 16:49:24 -0800 (PST)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id hc4sm34855572pbc.30.2013.01.05.16.49.22
        (version=SSLv3 cipher=OTHER);
        Sat, 05 Jan 2013 16:49:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <50E89275.6080408@gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212744>

Hi Manlio,

Manlio Perillo wrote:

> Many C projects I have seen (based on autoconf, but not always - like
> Nginx) allow the project to be build in a separate directory, in order
> to avoid to pollute the working directory with compiled files.
>
> Unfortunately this seems to not be possible with Git.

I believe the Cygwin build[1] does this, so that could be a starting
point if you want to work on it.

They use the VPATH variable[2].

Hope that helps,
Jonathan

[1] http://cygwin.com/ml/cygwin/2012-02/msg00391.html
[2] https://www.gnu.org/software/make/manual/html_node/General-Search.html#General-Search
