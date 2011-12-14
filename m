From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Branch names with slashes
Date: Wed, 14 Dec 2011 13:52:08 +0100
Message-ID: <4EE89BF8.6090700@alum.mit.edu>
References: <CAGcUY13TOodu1BO3DCoNnVvNZ9QkWAbD-RmyqQX6P1q6tcO+yg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Leonardo Kim <dalinaum@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 14 13:52:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaoJt-0006Co-5p
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 13:52:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754980Ab1LNMwN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Dec 2011 07:52:13 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:34873 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754670Ab1LNMwN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2011 07:52:13 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id pBECq8kS010734
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 14 Dec 2011 13:52:09 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 Thunderbird/3.1.15
In-Reply-To: <CAGcUY13TOodu1BO3DCoNnVvNZ9QkWAbD-RmyqQX6P1q6tcO+yg@mail.gmail.com>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187109>

On 12/14/2011 11:17 AM, Leonardo Kim wrote:
> Branch names can contain slashes, so we can use 'development/foo' as a
> branch name. If I choose 'development' as a branch name, it doesn't
> work. There is a directory named development at '.git/refs/heads'
> directory. So we cannot create a file named development for
> 'refs/heads/development'.
> 
> An error message may occurs like below. Unfortunately, It is not of help to me.
> 'error: 'refs/heads/development/foo' exists; cannot create
> 'refs/heads/development'.

Assuming that the wording of the error message is not considered part of
the external API, it is trivial to change it.  What do you suggest?

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
