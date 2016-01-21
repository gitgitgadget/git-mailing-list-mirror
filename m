From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH 0/4] Submodule Groups
Date: Thu, 21 Jan 2016 22:17:08 +0100
Message-ID: <56A14AD4.6040608@gmail.com>
References: <1453260880-628-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Jens.Lehmann@web.de, jrnieder@gmail.com
To: Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jan 21 22:17:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMMbf-0002TS-Cu
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jan 2016 22:17:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751896AbcAUVRY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2016 16:17:24 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34051 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751402AbcAUVRW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2016 16:17:22 -0500
Received: by mail-wm0-f65.google.com with SMTP id b14so13464214wmb.1
        for <git@vger.kernel.org>; Thu, 21 Jan 2016 13:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=zwWj4de90bU1EeBe9hhWjM6a9HcRpchST7MuNOfCvi4=;
        b=hu8Rpf0JmgiOVB7hWCUOa5B5ExZHQ6TQNTRa2Egmn8cxa4fa6Jz1dD4+UYOOHByOqe
         93QLVoazc+azF/My4jKaQvhhsUccuDhvciUT18xrO/reXnig2cQdItw6TcAUUxHhOiHM
         k3DIdEFLKznjC7Z/jIo4SbwOLf4XWOvM12X3Fk/cQhlsT7pOA+d+a+ziCCZn6VxGDtY5
         C9tTlYWKAPBJkA4/3WEwfG2phaPzWQF6xmLSBbkRdTNqT8UNqQ6sYyyPUQ8jO3T3KT/I
         G+p0RCKwqHilSRiFSOJe8bOIOb4qJnLNwObc0zEM5vZMeEK8o57qcVT0I9dnQol4HZst
         9BAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:newsgroups:from
         :message-id:date:user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=zwWj4de90bU1EeBe9hhWjM6a9HcRpchST7MuNOfCvi4=;
        b=ZsXCYjsf4+hvbXYrBoShvUFdAlevdsW076CY+iugrPfXkPlrDieMFi2a4BrBFzOq6w
         VWHQgXygwUP6bp1E/QivlUDBQ8vFVYqaCPg0GT69aAdKR7Atxu0Lb/JbTFBam/59EiKu
         fYNpf7sDDavGcOi4cZo7TJGCXQtpxGdUsJ3lNc7j2D7C8fAzzuDUt8vWQeaos4Kqu1Al
         VTINCwkAPqmVclucfg/2RbicGzlp8uoA6OsNBERIskLyYBXk5m0daE4gKVy9bbgKmTjf
         IFJO+hVWHl54MVOtJ/mdoXjASV1VQsjQlpSKfquB7Ru5zBCVQB7pFDFK4POlJQmwcbzF
         zQuw==
X-Gm-Message-State: AG10YOTf6YlUYYyfM0jJJ0xB9QQiHBMm/pyUco3eNomVYIverRLStzVTZM3M1mr4pTMJqg==
X-Received: by 10.28.111.217 with SMTP id c86mr11851304wmi.31.1453411041689;
        Thu, 21 Jan 2016 13:17:21 -0800 (PST)
Received: from [192.168.188.20] (p548D6A49.dip0.t-ipconnect.de. [84.141.106.73])
        by smtp.googlemail.com with ESMTPSA id t199sm63722wmt.23.2016.01.21.13.17.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 21 Jan 2016 13:17:20 -0800 (PST)
Newsgroups: gmane.comp.version-control.git
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12)
 Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
In-Reply-To: <1453260880-628-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284529>

On 20.01.2016 04:34, Stefan Beller wrote:

> So you could have a .gitmodules file such as:
> 
> [submodule "gcc"]
>          path = gcc
>          url = git://...
>          groups = default
>          groups = devel

On the quick I was unable to find the rationale why entries are now stored as separated lines compared to v1. I liked the comma-separated approach better as it's more compact.

Anyway, if it's only one group per line, I'd find it more fitting to call the entry "group" instead of "groups" as it will always refer to a single group only. Also that would better match the "--group" command line option naming for "submodule add".

However, if I'd read the single line "group = default" in a .gitmodules file, it wouldn't be immediately clear to me that "group" can appear multiple times per submodule. "groups = default" would me more hinting is this regard because the plural is used, but without reading the docs I'd assume multiple groups would be specified like "groups = default,devel".

Long story short, my personal favorite still would be 

[submodule "gcc"]
         groups = default,devel

followed by

[submodule "gcc"]
         group = default
         group = devel

-- 
Sebastian Schuberth
