From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [ANNOUNCE] GitJungle is out!
Date: Tue, 14 Dec 2010 16:46:29 +0100
Message-ID: <4D079155.4020102@alum.mit.edu>
References: <4D05FF8D.7080306@codicesoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "psantosl@codicesoftware.com" <psantosl@codicesoftware.com>
X-From: git-owner@vger.kernel.org Tue Dec 14 16:46:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSX5O-0005iA-18
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 16:46:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757638Ab0LNPqg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Dec 2010 10:46:36 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:42751 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757597Ab0LNPqf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Dec 2010 10:46:35 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id oBEFkTRT028478
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 14 Dec 2010 16:46:30 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.13) Gecko/20101208 Lightning/1.0b2 Thunderbird/3.1.7
In-Reply-To: <4D05FF8D.7080306@codicesoftware.com>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163654>

On 12/13/2010 12:12 PM, psantosl@codicesoftware.com wrote:
> We've just released GitJungle
> [...] The drawing approach we use is a little bit
> different from what other git tools are using: we draw horizontally
> instead of vertically, we think it is a better way but, you know, it is
> probably a matter of preference.

Given that git doesn't permanently record the branch that a commit was
first made on, how do you decide on what row to draw a commit?  E.g., if
I have two branches A and B that share a common ancestor

      o-o  <- A
     /
o-o-o
     \
      o-o  <- B

how do you decide whether to draw the ancestor on the row for A vs. the
row for B?

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
