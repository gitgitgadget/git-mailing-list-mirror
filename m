From: krishna chaitanya kurnala <kkc4al@gmail.com>
Subject: Git Notes - Search Functionality
Date: Wed, 27 Feb 2013 07:34:58 -0800
Message-ID: <CAFZnXLJCiq4G+_ZStWmjAGePWCD6mhske7Y4=oe2h==F0BYVLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 27 16:35:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UAj2t-00042R-K0
	for gcvg-git-2@plane.gmane.org; Wed, 27 Feb 2013 16:35:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760203Ab3B0PfV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2013 10:35:21 -0500
Received: from mail-oa0-f47.google.com ([209.85.219.47]:48506 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759785Ab3B0PfT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2013 10:35:19 -0500
Received: by mail-oa0-f47.google.com with SMTP id o17so1383893oag.20
        for <git@vger.kernel.org>; Wed, 27 Feb 2013 07:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=7ObpLvece9IpvDdwO1ykyGIa0l70ZRobPcw8KyeQxVw=;
        b=VJYJGkruE9I0Z84JNzFu+gONEHFbCRseb7dz/lcwHxn+Cu0v+vK5H0KBBDZ6y5a4uq
         SrQKF2qFXWBHmMgDwaiA195LlK3nLwBcnqDTQoXzhlt8+uQ+4IYow+DsN6gZJdfGvKU4
         0UphBpElxEukNq8e1CfLbiYkQOnfT4aMsbJCwwgRTvH7pcUpyf1SevCmkRFCRvlUmz2f
         30j/CIZEvg5t34I7XPIFQk6jy57cX09MBibMX6CGr4whDrrfQHQcrqiV5U7byJJslrz3
         FRvsT9EoDSvFqwiyLkHAHJAm+cr6KqrT3AtQP/LtrMsDCcDc6yfSmjYNGlGWYypA/fAC
         +nXg==
X-Received: by 10.182.2.132 with SMTP id 4mr2579880obu.42.1361979319228; Wed,
 27 Feb 2013 07:35:19 -0800 (PST)
Received: by 10.60.0.197 with HTTP; Wed, 27 Feb 2013 07:34:58 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217211>

Hello All

   I working on Git Notes. I want to know if there is an easy way to
obtain a list of all "namespaces"(For eg., git notes --ref=namespace
... ) with notes objects in a specific git repository. We can easily
create, edit, merge git notes with commands if we know the namespaces
and/or the sha. But, for example, Has anyone tried to search for a
string in a git notes objects for that project etc?
  The closest i can think of is using some options with git logs, for
example, git log --show-notes=*  --format="%H %N" etc.

Appreciate your time.

thanks
Krishna Chaitanya
