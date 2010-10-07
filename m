From: Casey Dahlin <cdahlin@redhat.com>
Subject: Re: Git over SMBFS
Date: Thu, 7 Oct 2010 13:40:06 -0400
Message-ID: <20101007174006.GA31711@fearengine.rdu.redhat.com>
References: <AANLkTik9U_jr6r6BuUcRrk8pjQTacKDY7YbqWnfrCLmD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: fREW Schmidt <frioux@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 07 19:40:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3uS3-0006Sg-Et
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 19:40:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751429Ab0JGRkL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Oct 2010 13:40:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:21352 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750962Ab0JGRkK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Oct 2010 13:40:10 -0400
Received: from int-mx03.intmail.prod.int.phx2.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.16])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id o97He9sq026835
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Thu, 7 Oct 2010 13:40:09 -0400
Received: from fearengine.rdu.redhat.com (dhcp243-150.rdu.redhat.com [10.11.243.150])
	by int-mx03.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id o97He6xq012391
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 7 Oct 2010 13:40:08 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTik9U_jr6r6BuUcRrk8pjQTacKDY7YbqWnfrCLmD@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.16
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158411>

On Tue, Oct 05, 2010 at 09:26:15PM -0500, fREW Schmidt wrote:
> A coworker of mine is working on a project that is running on a
> windows server.=A0 The project is in git, but we are having a lot of
> trouble getting it to work at all.=A0 For example, if he merely does
> (from his machine) "git checkout ." it seemingly times out after 680
> files being checked out.
>=20
> Are there any settings we might be able to tweak that might make git
> more tolerable of the latency involved in a network based checkout?
>=20

Sounds to me like the best way would be to make a local copy with

git clone /path/to/cifs/mounted/project

And then do your work on the local hard disk. Later, you can git-push
back in to the cifs folder.

--CJD
