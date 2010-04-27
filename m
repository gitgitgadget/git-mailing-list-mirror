From: Mark Rada <marada@uwaterloo.ca>
Subject: Re: [PATCH] gitweb: Improve installation instructions in gitweb/INSTALL
Date: Tue, 27 Apr 2010 16:40:11 -0400
Message-ID: <4BD74BAB.1040401@mailservices.uwaterloo.ca>
References: <20100427203341.31445.82930.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 27 22:40:31 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6ra2-0001mY-EO
	for gcvg-git-2@lo.gmane.org; Tue, 27 Apr 2010 22:40:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756411Ab0D0UkW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Apr 2010 16:40:22 -0400
Received: from mailservices.uwaterloo.ca ([129.97.128.141]:54547 "EHLO
	mailchk-m05.uwaterloo.ca" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756391Ab0D0UkT (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Apr 2010 16:40:19 -0400
Received: from karakura.local (static-66-225-153-161.ptr.terago.net [66.225.153.161])
	(authenticated bits=0)
	by mailchk-m05.uwaterloo.ca (8.13.8/8.13.8) with ESMTP id o3RKeBwj026831
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 27 Apr 2010 16:40:12 -0400
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <20100427203341.31445.82930.stgit@localhost.localdomain>
X-UUID: 84b546af-3844-4b09-b7ae-7bb048a9efb7
X-Miltered: at mailchk-m05 with ID 4BD74BAB.000 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
X-Virus-Scanned: clamav-milter 0.96 at mailchk-m05
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-3.0 (mailchk-m05.uwaterloo.ca [129.97.128.141]); Tue, 27 Apr 2010 16:40:16 -0400 (EDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145950>

On 10-04-27 4:33 PM, Jakub Narebski wrote:
> +  The above instruction assumes that you didn't use JavaScript
> +  minimizer or CSS minimizer.  If you use minimizers you need
> +  to modify above instructions accordingly, which means pointing
> +  GITWEB_CSS and GITWEB_JS to minified versions, and copying 
> +  minified files.
> +
>  

Hmm, I believe I already put a message like this in the INSTALL
file. Perhaps that message should be updated, too, or removed in
place of your patch.

Looks like:
 67 
 68 - You can optionally generate minified versions of gitweb.js and gitweb.css
 69   by defining the JSMIN and CSSMIN build configuration variables. By default
 70   the non-minified versions will be used. NOTE: if you enable this option,
 71   substitute gitweb.min.js and gitweb.min.css for all uses of gitweb.js and
 72   gitweb.css in the help files.



-- 
Mark Rada
marada@uwaterloo.ca
