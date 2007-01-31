From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: What did I just fetch?
Date: Wed, 31 Jan 2007 14:30:56 +0100
Message-ID: <8aa486160701310530t6325ea2ah2e58bc250a37ce97@mail.gmail.com>
References: <17856.37307.324767.617892@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Bill Lear" <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Wed Jan 31 14:31:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCFYJ-0001QJ-PP
	for gcvg-git@gmane.org; Wed, 31 Jan 2007 14:31:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933255AbXAaNbE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Jan 2007 08:31:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933270AbXAaNbE
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Jan 2007 08:31:04 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:47094 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933255AbXAaNbC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jan 2007 08:31:02 -0500
Received: by ug-out-1314.google.com with SMTP id 44so169570uga
        for <git@vger.kernel.org>; Wed, 31 Jan 2007 05:30:57 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LRwWdhk+peeT0zSWgX5/TJU7xXJgsanmscQ+aqnHJ3X4XbN1+J1vuLhaNkGpCrGdIm4eC7oCBCxjXcR0ICJmakS+v7HbJo0QXxTkQnpQnn5uolMy3FyzHKKqmJzfChDq9T6S58zF786te40RLFAPSd5OWDwTi5fDozC0Nizmle0=
Received: by 10.78.166.7 with SMTP id o7mr159193hue.1170250257208;
        Wed, 31 Jan 2007 05:30:57 -0800 (PST)
Received: by 10.78.68.8 with HTTP; Wed, 31 Jan 2007 05:30:56 -0800 (PST)
In-Reply-To: <17856.37307.324767.617892@lisa.zopyra.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38249>

On 1/31/07, Bill Lear <rael@zopyra.com> wrote:
> When updating in cvs, I get a list of files changed by the update.
>
> How can I do this in git when fetching into a bare repo?
>
> % GIT_DIR=. git fetch git://source/project
> remote: Generating pack...
> remote: Done counting 18 objects.
> remote: Result has 10 objects.
> remote: Deltifying 10 objects.
> remote:  100% (10/10) done
> Unpacking 10 objects
> remote: Total 10, written 10 (delta 6), reused 7 (delta 3)
>  100% (10/10) done

You are just fetching the objects, but you are not storing the tip of
the branch (in this case HEAD) anywhere.

Use the verbose flag (-v) to get the commit hash

$ git fetch -v ${remote}
....
* fetched ${remote}
  commit: ${hash}

Santi
