From: "Yossi Leybovich" <sleybo@gmail.com>
Subject: Re: corrupt object on git-gc
Date: Fri, 9 Nov 2007 08:38:39 -0500
Message-ID: <4fe79b4b0711090538wf483ce7j89c518962e89780e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, ae@op5.se,
	"Yossi Leybovich" <sleybo@mellanox.co.il>
X-From: git-owner@vger.kernel.org Fri Nov 09 14:38:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqU4W-00065a-EV
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 14:38:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759252AbXKINil (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 08:38:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754273AbXKINil
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 08:38:41 -0500
Received: from rv-out-0910.google.com ([209.85.198.187]:10884 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759252AbXKINik (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 08:38:40 -0500
Received: by rv-out-0910.google.com with SMTP id k20so468255rvb
        for <git@vger.kernel.org>; Fri, 09 Nov 2007 05:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=QCvJcznRd/GLJbupT4eC10K0aoVq0JNKmc73HOf8bmk=;
        b=J1AoNw3iCttSx1r9trs8CnvW+VhaNyqfEr/DlMqPVqjYJzTK9dB8orHqA+m0JBc33bdwdp+8Gkt1c7PdSeKBwp+eXaadjtaf3le3LYclYZZFLDrvd2v5DQy5F4q5GfLVKdQPE2LDhT92n51gvuoORM+zpxdnrKioepPBFhsnYtM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=s/c9X4CP84/DpxbbvvylqRKcNZOWn4H6erPgSlkVhuZoXH/jgmZNKx41uFMeh63d1OyuUOi2Ph3oTNYA8lCht/BwMetLyDkubCOTup2WdJ2Oy9TKMh2t+aWfVwfPoKUyotbo927IAsZ31EbiXEJvSW7w2eq8FKbmTAC1NY7nyuw=
Received: by 10.114.184.7 with SMTP id h7mr393201waf.1194615519968;
        Fri, 09 Nov 2007 05:38:39 -0800 (PST)
Received: by 10.114.174.5 with HTTP; Fri, 9 Nov 2007 05:38:39 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64177>

Yossi Leybovich wrote:
>> Hi
>>
>>  I know its loose but still I think there are references in the
>> repository to this object.
>> How I can remove it from the repository ?
>>

>That was not a very good idea. You just moved ALL objects whose hash
>begin with 4b out of the object database.

>Try only moving the offending file out of the 4b directory.

Did not help still the repository look for this object?
Any one know how can I track this object and understand which file is it



ib]$ mv .git/objects/4b/9458b3786228369c63936db65827de3cc06200 ../

ib]$ git-fsck --full
dangling commit 0d43a63623237385e432572bf61171713dcd8e98
dangling commit 4fc6b1127e4a7f4ff5b65a2dd8a90779b5aff3e0
dangling commit 7da607374fe2b1ae09228d2035dd608c73dad7c8
dangling commit 004ef09ae022c60a30f9cd61f90d18df5db3628e
dangling commit 85112c6fabb6b8913ab244a8645d67380616eba6
broken link from    tree 2d9263c6d23595e7cb2a21e5ebbb53655278dff8
             to    blob 4b9458b3786228369c63936db65827de3cc06200
missing blob 4b9458b3786228369c63936db65827de3cc06200
dangling commit bd98481afa93356fa6daa4b6f88c4e631ae2fd72
dangling commit e81e3d2c9c25e5bf5b31327b10b23f9bd0a6d056
dangling commit 92ff9b8cbc771345c9cde0c7fef2c23bb79242b9
