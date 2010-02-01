From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Wishlist for branch management
Date: Sun, 31 Jan 2010 19:22:12 -0800
Message-ID: <4B6648E4.6070805@zytor.com>
References: <4B662BEF.7040503@zytor.com> <20100201013155.GA11832@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?B?QmrDtnJuIFN0ZWluYnJpbms=?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 01 04:25:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nbmui-0005qZ-UM
	for gcvg-git-2@lo.gmane.org; Mon, 01 Feb 2010 04:25:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753860Ab0BADWQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 31 Jan 2010 22:22:16 -0500
Received: from terminus.zytor.com ([198.137.202.10]:37872 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753246Ab0BADWQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jan 2010 22:22:16 -0500
Received: from mail.hos.anvin.org (c-98-210-181-100.hsd1.ca.comcast.net [98.210.181.100])
	(authenticated bits=0)
	by mail.zytor.com (8.14.3/8.14.3) with ESMTP id o113MDVs011887
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 31 Jan 2010 19:22:13 -0800
Received: from tazenda.hos.anvin.org (tazenda.hos.anvin.org [172.27.0.16])
	by mail.hos.anvin.org (8.14.3/8.14.3) with ESMTP id o113MCWa014231
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 31 Jan 2010 19:22:12 -0800
Received: from tazenda.hos.anvin.org (localhost.localdomain [127.0.0.1])
	by tazenda.hos.anvin.org (8.14.3/8.13.6) with ESMTP id o113MCoX023968;
	Sun, 31 Jan 2010 19:22:12 -0800
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.7) Gecko/20100120 Fedora/3.0.1-1.fc11 Thunderbird/3.0.1
In-Reply-To: <20100201013155.GA11832@atjola.homenet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138576>

On 01/31/2010 05:31 PM, Bj=C3=B6rn Steinbrink wrote:
>=20
>> git push --current
>>
>> ... push the current branch, and only the current branch...
>=20
> Unless you want to push to a different ref remotely, e.g. pushing
> refs/heads/master-public to refs/heads/master, you can use:
> 	git push <remote> HEAD
>=20
> For example, when refs/heads/master is checked out, then:
> 	git push origin HEAD
> acts the same as:
> 	git push origin refs/heads/master
>=20

Whatever is used, it should respect the configuration.  This requires
knowing what the configuration is set up as.

	-hpa

--=20
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
