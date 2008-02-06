From: "Peter Harris" <git@peter.is-a-geek.org>
Subject: Re: what does @NNN in git-svn branch names mean?
Date: Wed, 6 Feb 2008 11:37:09 -0500
Message-ID: <eaa105840802060837r200ed5f9l7104aa7257793af8@mail.gmail.com>
References: <20080206162905.GA29432@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Eric Wong" <normalperson@yhbt.net>, git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 17:38:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMnHN-0001Ev-Et
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 17:37:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752830AbYBFQhP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Feb 2008 11:37:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752833AbYBFQhP
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 11:37:15 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:17052 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752723AbYBFQhN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Feb 2008 11:37:13 -0500
Received: by nf-out-0910.google.com with SMTP id g13so745989nfb.21
        for <git@vger.kernel.org>; Wed, 06 Feb 2008 08:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=/fEqtZvlGIhsTSy/o4ybsXZ8XBVCoFF22PHL28utQXo=;
        b=a7ui49V5SHCzvSQSuIzX/iwhngHm0UXP91M+30A1vSuro0yzAc4WHQY9Kq2dukv51G0KpUxLtdbGdFhQangiepqQXkKqf5w6bpYWhv7WfoWoviYnAjWWjqYCLIAbE+hvF1XbpSwvCPft9w6wLWvuG6Pq+FL4O3Y+E7NZuJk6XeU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=ZsE4IY3cZIBKagocKTps1EhrJfktVK5Sux45ya1NUZxOqp87Yff1eR5YKarVi5GCfuSsU6OPDvK4P0V2eQwrdT12MHWRlKR6cm0hjmFWZGKbMX6BXMvqV+6Ms5NTorUyOfOZkTVOS1S870agK2vFWIKEDSBmbUBbosPUK1kySVo=
Received: by 10.78.139.14 with SMTP id m14mr18069592hud.25.1202315829313;
        Wed, 06 Feb 2008 08:37:09 -0800 (PST)
Received: by 10.78.203.14 with HTTP; Wed, 6 Feb 2008 08:37:09 -0800 (PST)
In-Reply-To: <20080206162905.GA29432@diana.vm.bytemark.co.uk>
Content-Disposition: inline
X-Google-Sender-Auth: 32a58aed84e02bd0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72811>

On Feb 6, 2008 11:29 AM, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> What does it mean when git-svn creates branches with an @ sign and a
> Subversion revision number in them? The documentation doesn't say
> (and, this being perl, grepping for "@" in git-svn.perl is of little
> use!). I'll be happy to write something up if you'll clue me in.

It looks like this happens when a branch is deleted and recreated. The
old branch "foo" is renamed to "foo@lastrev", and the new branch "foo"
tracks the current state.

Peter Harris
