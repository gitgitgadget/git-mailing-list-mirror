From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [PATCH] gitk: Add a "Save file as" menu item
Date: Sun, 21 Jul 2013 19:13:08 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1307211910250.9615@ds9.cixit.se>
References: <87ppuculyi.fsf@msstf091.ucc.ie>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Andreas Amann <a.amann@ucc.ie>
X-From: git-owner@vger.kernel.org Sun Jul 21 20:13:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0y8o-0001RR-6i
	for gcvg-git-2@plane.gmane.org; Sun, 21 Jul 2013 20:13:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755966Ab3GUSNu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jul 2013 14:13:50 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:58037 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755948Ab3GUSNt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jul 2013 14:13:49 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-9.4) with ESMTP id r6LID9u1009806
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 21 Jul 2013 20:13:09 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id r6LID8kc009802;
	Sun, 21 Jul 2013 20:13:08 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <87ppuculyi.fsf@msstf091.ucc.ie>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.3.7 (mail.cixit.se [127.0.0.1]); Sun, 21 Jul 2013 20:13:09 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230939>

Andreas Amann:

> +    set difffile "$diffidtext [file tail $flist_menu_file]"
> +    set difffile [tk_getSaveFile -initialfile $difffile -title "Save file as" -parent .]
> +    if {$difffile eq {}} {
> +	return
> +    }
> +    save_file_from_commit $diffid:$flist_menu_file $difffile "revision $diffid"

I might be misunderstanding the code (this is not one of my preferred 
programming languages), but it looks like this is missing the gettext 
markers necessary to get these strings localized.

-- 
\\// Peter - http://www.softwolves.pp.se/
