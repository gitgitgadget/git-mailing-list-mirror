From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Zit (v2): the git-based single file content tracker
Date: Mon, 27 Oct 2008 00:04:12 +0200
Message-ID: <200810262304.13582.jnareb@gmail.com>
References: <gdok16$vh2$1@ger.gmane.org> <m3k5bvgz83.fsf@localhost.localdomain> <cb7bb73a0810261418y3b114e2ag81cbb75c4a80603c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 26 23:06:04 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuDjn-0004zd-OT
	for gcvg-git-2@gmane.org; Sun, 26 Oct 2008 23:05:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752360AbYJZWET (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Oct 2008 18:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752335AbYJZWES
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Oct 2008 18:04:18 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:29075 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752296AbYJZWES (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Oct 2008 18:04:18 -0400
Received: by nf-out-0910.google.com with SMTP id d3so568598nfc.21
        for <git@vger.kernel.org>; Sun, 26 Oct 2008 15:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=LyzmtF2g44zCM2bH5Eg6UPLuhMQUcGpyaptD8nP4uLE=;
        b=Ltok0tkQm8iNwaAvle89+OpwrZcc7moVl1zOL9S3eEXVrsW1bHRFU7NuVJnIsqesjh
         T4QbPsRpqbTVxe/PnfjvkEfdLoSWuaIOfL89caaEyOvbtPQQTkIkXsMo6wZCFL4g8hQk
         uHtf6FD3PLnbs4LVhKfQLCs1Jt0xVtpdp9XQo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=RrI9F7Tgizqe6q6Ro8RimXwMWMh0wq30zkm5TRcXNidOdH7GguifwtYEin9XE9A3O9
         /YcPnoCALleotoeQcufAP9DuMoOjJlKvbH9/8xL6y8NrRK6sCMYOetUG1IaNCpi8j14U
         OL9n4CqKuEN08R4c39h/IaYgoXwgRU/QymRoA=
Received: by 10.210.133.2 with SMTP id g2mr4272232ebd.99.1225058656202;
        Sun, 26 Oct 2008 15:04:16 -0700 (PDT)
Received: from ?192.168.1.11? (abvq236.neoplus.adsl.tpnet.pl [83.8.214.236])
        by mx.google.com with ESMTPS id 23sm4710022eya.7.2008.10.26.15.04.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 26 Oct 2008 15:04:14 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <cb7bb73a0810261418y3b114e2ag81cbb75c4a80603c@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99186>

Giuseppe Bilotta wrote:
> On Sun, Oct 26, 2008 at 4:20 PM, Jakub Narebski <jnareb@gmail.com> wrote:
>> "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com> writes:
>>>
>>> Ah, good idea. Done, in Version Control Interface layers section
>>
>> Thanks.
>>
>> I have added link to repositoy, as you didn't configure your gitweb to
>> display those URL links (see gitweb/README and gitweb/INSTALL).
> 
> Oops, right, thanks. BTW, isn't there a way to have the git:// URL be
> computed automatically? Judging by the docs, it seems that I have to
> set it manually for each project, like the description.

gitweb/README:

  How to configure gitweb for your local system
  ---------------------------------------------
  [...]
   * GITWEB_BASE_URL
     Git base URLs used for URL to where fetch project from, i.e. full
     URL is "$git_base_url/$project".  Shown on projects summary page.
     Repository URL for project can be also configured per repository; this
     takes precedence over URLs composed from base URL and a project name.
     Note that you can setup multiple base URLs (for example one for
     git:// protocol access, another for http:// access) from the gitweb
     config file.  [No default]

  [...]
  Runtime gitweb configuration
  ----------------------------
  [...]
  Gitweb config file variables
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  [...]
   * @git_base_url_list
     List of git base URLs used for URL to where fetch project from, shown
     in project summary page.  Full URL is "$git_base_url/$project".
     You can setup multiple base URLs (for example one for  git:// protocol
     access, and one for http:// "dumb" protocol access).  Note that per
     repository configuration in 'cloneurl' file, or as values of gitweb.url
     project config.

Ooops, there seems to be a type in above...

  Per-repository gitweb configuration
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  [...]
   * cloneurl (or multiple-valued gitweb.url)
     File with repository URL (used for clone and fetch), one per line.
     Displayed in the project summary page. You can use multiple-valued
     gitweb.url repository configuration variable for that, but the file
     takes precedence.

-- 
Jakub Narebski
Poland
