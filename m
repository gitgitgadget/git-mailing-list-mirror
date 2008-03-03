From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [RFC] git-submodule: multiple-level modules definition
Date: Mon, 3 Mar 2008 07:57:37 +0100
Message-ID: <8c5c35580803022257n7ff0cdc3i1e72a0034d254aa4@mail.gmail.com>
References: <46dff0320803020911m30c8e3b3w80c0c92258a45f0f@mail.gmail.com>
	 <8c5c35580803021018v7590ad76kbbab2b1113e27666@mail.gmail.com>
	 <46dff0320803021747y6e334903pf8b5a77168bc7882@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Ping Yin" <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 07:58:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JW4dD-0005do-In
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 07:58:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752197AbYCCG5l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 01:57:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751965AbYCCG5l
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 01:57:41 -0500
Received: from gv-out-0910.google.com ([216.239.58.190]:40767 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751141AbYCCG5l (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 01:57:41 -0500
Received: by gv-out-0910.google.com with SMTP id s4so2660167gve.37
        for <git@vger.kernel.org>; Sun, 02 Mar 2008 22:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=oozB7EugSmDCE6ROY9w8hjCFNz6R8k/pltxg7hZ+CM4=;
        b=UXVfUYc9ZLuP7ZjlK78KtP9WbqQX21iY04OWlLxh3wZ5g8pmSjkQ9fG0jLtu564WVgdnxPTOyj7fKLTCdmMkLOZ5EBIkdGwJ2MqRzqCVK0AXkV3jEGnvpA2QgCNWarLO4iEAwG+Z6SnMQbaHqPmB8Tmnt95r6PQ0yK1xb0DPx/A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=otdHS3K4fhW7Mo3JJEutSHiEFrZxe6Y9I7M4gqHj/OwFAAf9NNcJpJ8FxO//z4VYBYX5QrVp/AFuE//CFAxRvft015PGtZU54dy9BSJsoXQn+78AlAc2KPf3OLneA1DGppYH8saSk55pJEXpPrbsupinG88nJBYfXepsolSGlAk=
Received: by 10.114.130.1 with SMTP id c1mr4087580wad.52.1204527457683;
        Sun, 02 Mar 2008 22:57:37 -0800 (PST)
Received: by 10.114.241.8 with HTTP; Sun, 2 Mar 2008 22:57:37 -0800 (PST)
In-Reply-To: <46dff0320803021747y6e334903pf8b5a77168bc7882@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75891>

On Mon, Mar 3, 2008 at 2:47 AM, Ping Yin <pkufranky@gmail.com> wrote:
>  But why always
>  use git init even when we don't have the local configuration
>  requirement?

We need a way to tell git which of those submodules we are interested
in, i.e. which submodules to clone/fetch during 'git submodule
update'.

--
larsh
