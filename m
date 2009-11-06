From: Tim Rupp <caphrim007@gmail.com>
Subject: suggestions for local configs?
Date: Thu, 05 Nov 2009 21:11:42 -0600
Message-ID: <4AF393EE.4030205@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 06 04:12:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6FEz-0006PM-6U
	for gcvg-git-2@lo.gmane.org; Fri, 06 Nov 2009 04:11:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754627AbZKFDLp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2009 22:11:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754436AbZKFDLp
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Nov 2009 22:11:45 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:46075 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752219AbZKFDLo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2009 22:11:44 -0500
Received: by yxe17 with SMTP id 17so591068yxe.33
        for <git@vger.kernel.org>; Thu, 05 Nov 2009 19:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=Ni5B/toRep3jGi7pKTEVG4LuijYcNeQFqNh8z8zZtas=;
        b=cgEurGKsmG9QTHTaPtXLAg5iRa+dTuFIbeYOxRpt00+8WdCrMv6INb/ZFg4q+FpOYl
         9zCwarzDk+RONFwWNNCGlGq7A65saGHpn/SZQcW0k8IDznjwRsB952UDdBeJGZZUy1NC
         c6WugtibNc+5NO0WP9iB9ORImxaaDGSst046o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=OqHO1pE8mGMWtfndjF5OLsNzWrXJ5FUfYOmsWhqduxXMwy94sC8nUmk8PMATGHftCE
         bpIFtT4g/anusQlyfNVPMLp4pyICoKB/JvldxuaMdylhsMmLZYUAdssZag3HO/g9ZyZV
         OsOXQvqYwZG02w4bDgkctfW/D1/tUzlqb/POk=
Received: by 10.151.93.20 with SMTP id v20mr6794690ybl.59.1257477108836;
        Thu, 05 Nov 2009 19:11:48 -0800 (PST)
Received: from ?172.16.1.101? (adsl-70-131-103-6.dsl.emhril.sbcglobal.net [70.131.103.6])
        by mx.google.com with ESMTPS id 15sm873795gxk.0.2009.11.05.19.11.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 05 Nov 2009 19:11:47 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132269>

Hi list, I'm wrestling with a question and figured that someone on the
list may have some suggestions that have worked for them.

I have a piece of software that has default and local configuration
files. The default files ship with the tarball. The local files are
copied over from the default folder during installation and can be
modified for a particular install.

I clone my source repo on my test and prod systems, but have gotten in
the bad habit of versioning the local configuration files. My (albeit
pathetic) excuse is that when I test the code I may accidentally dork
with the local config files and need to revert back to the correct ones.

At the same time though, I do want to version said local configs in
something so that if changes are made and they need to be backed out, it
can be done and there is the commit log that keeps track of what changed.

So the question is

- Can anyone suggest good ways of setting up git to track both the code
and local configs without making a whole new repository (code repo and
code config repo)

If not, any other suggestions are welcome and I'll consider how best to
make them work in my environment.

I've briefly skimmed through the pro git book online and considered sub
modules and sub-tree merging, but the kicker is that I may need to push
the whole kit-n-kaboodle master repo to remote git servers and those two
approaches sound hairy.

Any help is appreciated.

Thanks,
Tim
