From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git log: Add a switch to limit the number of displayed lines
 from the commit messages
Date: Sat, 15 Jun 2013 12:19:05 -0700
Message-ID: <20130615191905.GA3363@elie.Belkin>
References: <1371319623.9845.34.camel@mattotaupa>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paul Menzel <paulepanter@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Sat Jun 15 21:19:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Unw0O-0000HZ-Lp
	for gcvg-git-2@plane.gmane.org; Sat, 15 Jun 2013 21:19:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754511Ab3FOTTQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Jun 2013 15:19:16 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:51015 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754363Ab3FOTTP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Jun 2013 15:19:15 -0400
Received: by mail-pa0-f45.google.com with SMTP id bi5so1633056pad.18
        for <git@vger.kernel.org>; Sat, 15 Jun 2013 12:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=AS/jEyVoMPrN0qUOnbqZ2y8Y0gxZuMFFbYcm0/3q2lo=;
        b=pb2CVBhstLG/St6QXakU8n2kVQY3LBSXKJsYN9lbTlcSmt7BHfh/HFgPHulqrHvw9z
         flPNbvasvFoiJZuPyUqtIYYzx08AkPIa391uZH+kQUiHYcdBTgMG7cy/YLV0nncU+EFw
         6WkmplHeafnT+/kqLjkYtlJAG7m9993wcTaSkdGffUsKJixhlSJAhIK/jAG7Iku6+YW1
         PIxtuOikkAopbPmNBetoPlyvdVuI4WxP+rS6sxqbuwy7g3W7ntjW0FCIyGvLfWoFu6tm
         AqSSDG19zKzX8YNoQJ4gHb+ngraomnNyFXaIkl12/z7Pdb9iSuodpnvQp/18J8tb7dA4
         xdKw==
X-Received: by 10.68.189.67 with SMTP id gg3mr7272019pbc.141.1371323955012;
        Sat, 15 Jun 2013 12:19:15 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id i16sm7739891pag.18.2013.06.15.12.19.13
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 15 Jun 2013 12:19:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1371319623.9845.34.camel@mattotaupa>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227967>

Hi Paul,

Paul Menzel wrote:

> there are people out there disliking elaborate commit messages, as going
> over `git log` is tedious as you have to scroll a lot. As I do not like
> the suggestion to make commit messages shorter by omitting certain
> details, a way to limit the number displayed lines of the commit
> messages would be nice to have.

Have you tried gitk or tig?  They split the screen so you can browse
through commits, one per line, in one half and read the corresponding
commit messages and patches in the other.

Hope that helps,
Jonathan
