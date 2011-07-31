From: Michael Witten <mfwitten@gmail.com>
Subject: Re: File Systems and a Theory of Edits
Date: Sun, 31 Jul 2011 11:56:53 -0000
Message-ID: <8f33c6bd053f4f89a2766c542773c38c-mfwitten@gmail.com>
References: <CADo4Y9hG=-Bye5g7OWROJNbbUOcnH0hj0f3csws5V+YzEUKAMg@mail.gmail.com>
            <23101-1312054868-691056@sneakemail.com>
Cc: git@vger.kernel.org
To: "John M. Dlugosz" <ngnr63q02@sneakemail.com>
X-From: git-owner@vger.kernel.org Sun Jul 31 14:09:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnUph-000781-Gs
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jul 2011 14:09:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753387Ab1GaMF0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jul 2011 08:05:26 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:33755 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753377Ab1GaMFY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jul 2011 08:05:24 -0400
Received: by pzk37 with SMTP id 37so9567311pzk.1
        for <git@vger.kernel.org>; Sun, 31 Jul 2011 05:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=subject:date:from:to:cc:message-id:in-reply-to:references;
        bh=s7CbxHrckJ58gIfKuUi4oF+Tgci/HZ9JhnxCr/U5XDg=;
        b=E8eBvqFQ8yHHrZ0nf1XI+XBOSD34VszhO4g5uvqqrIpkEZlSZEv7f06ryhipk3X/UY
         YZv/scx0fEJAtrQxsFQOEcmaJXMKtKUxanD0Foynyt8a88FdhzHt6h5Dns2KLG11pNjy
         /M2EEdtqscEf9B+iNg+XHe1zxlchGccueB6dE=
Received: by 10.68.22.103 with SMTP id c7mr1359079pbf.149.1312113924145;
        Sun, 31 Jul 2011 05:05:24 -0700 (PDT)
Received: from gmail.com (zeller.torservers.net [74.120.12.135])
        by mx.google.com with ESMTPS id m7sm4310473pbk.54.2011.07.31.05.05.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 31 Jul 2011 05:05:22 -0700 (PDT)
In-Reply-To: <23101-1312054868-691056@sneakemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178246>

On Sat, 30 Jul 2011 14:40:57 -0500, John M. Dlugosz wrote:

> On 7/30/2011 9:29 AM, Michael Nahas wrote:
> 
>> For these commands to work, the git command will have to include an
>> argument that specifies which commit it operates on.  So some basic
>> ones might be:
>>      "git ls<commit>  -- <path>"
>>      "git cat<commit>  -- <path>"
>> (There exists "git ls-files", "git ls-tree", and "git cat-file" but
> 
> If you could "mount" a repository, then you would not need these commands at all.  It 
> would be in fact a read-only file system.  Once mounted, the individual commits could be 
> directories, and under that you explore in the usual way.

You can do this kind of thing with Avery Pennarun's
most awesome `bup' tool, which is based on git, and
it is indeed very useful.

See the whole thread here:

 Subject: Request: Auto-joining large files by 'bup fuse'
 Message-ID: <5f12a43ec3dc4250a7672725f5c172fc-mfwitten@gmail.com>
 http://groups.google.com/group/bup-list/browse_thread/thread/f80f56981853698b
