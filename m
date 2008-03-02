From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [RFC] git-submodule: multiple-level modules definition
Date: Sun, 2 Mar 2008 19:18:45 +0100
Message-ID: <8c5c35580803021018v7590ad76kbbab2b1113e27666@mail.gmail.com>
References: <46dff0320803020911m30c8e3b3w80c0c92258a45f0f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Ping Yin" <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 02 19:19:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVsmT-0002ra-Qp
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 19:19:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754134AbYCBSSt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 13:18:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751663AbYCBSSt
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 13:18:49 -0500
Received: from gv-out-0910.google.com ([216.239.58.187]:58428 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751304AbYCBSSs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 13:18:48 -0500
Received: by gv-out-0910.google.com with SMTP id s4so2456526gve.37
        for <git@vger.kernel.org>; Sun, 02 Mar 2008 10:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=3t0zJXGGW44P8q7ziAmrovSn9VAMbb/WESAW4lA2kOo=;
        b=nz47SSuifdPfA/bNGD2+KW+a/hFHvLA66Hmiox3WCLne1Lj3ulWpaT+zB0YbtrZQDFUyv282OKFuLEqaacecffecaL9W+OE4i2MhZScH0KdoT7bTtO/q/R5dQuXKzPMPGbEuOA38Eghggk8Hu0fZGR4OQ/o35Drb6iTYYwesucM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NWG6X1SUud6H04azK0/DVPaibp+EWtR1aYNzceaz22uT4aqd/r5vkAPdOx4dwZ+EthKwxzEKNulryOvq6FzWTdaDf0TigWjfXhqdw8Cc8MuYrSG44Sw2G/CN+vW/IyAOz78IbSRG/zrCNXIJknHe2W1UsgXr2By9BpnzhNoqWz0=
Received: by 10.114.150.1 with SMTP id x1mr3782042wad.46.1204481925391;
        Sun, 02 Mar 2008 10:18:45 -0800 (PST)
Received: by 10.114.241.8 with HTTP; Sun, 2 Mar 2008 10:18:45 -0800 (PST)
In-Reply-To: <46dff0320803020911m30c8e3b3w80c0c92258a45f0f@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75827>

On Sun, Mar 2, 2008 at 6:11 PM, Ping Yin <pkufranky@gmail.com> wrote:
>  4. Do we really need 'init' subcommand?

Yes: .git/config tells git which submodule(s) the user is interested
in and where to fetch updates from for these submodules, while
.gitmodules is used to map a submodule _name_ to a submodule _path_
and also to provide a url where submodule updates _can_ be fetched.

So the actual use of submodules is strictly a local configuration
issue and as such it needs to be kept in .git/config. And to help the
user populate .git/config with submodule information we have 'git
submodule init'.

--
larsh
