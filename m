From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Make "git am" properly unescape lines matching ">>*From "
Date: Tue, 08 Jun 2010 15:10:22 -0700
Message-ID: <4C0EBFCE.4050700@zytor.com>
References: <87hbldjo0s.fsf@yoom.home.cworth.org> <4C0EAD00.8000706@zytor.com> <87typdi44d.fsf@yoom.home.cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Carl Worth <cworth@cworth.org>
X-From: git-owner@vger.kernel.org Wed Jun 09 00:12:19 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OM71s-0006IM-Sr
	for gcvg-git-2@lo.gmane.org; Wed, 09 Jun 2010 00:12:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756708Ab0FHWL4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jun 2010 18:11:56 -0400
Received: from terminus.zytor.com ([198.137.202.10]:50879 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756704Ab0FHWLz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jun 2010 18:11:55 -0400
Received: from anacreon.sc.intel.com (hpa@localhost [127.0.0.1])
	(authenticated bits=0)
	by mail.zytor.com (8.14.3/8.14.3) with ESMTP id o58MAMLZ015607
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Tue, 8 Jun 2010 15:10:22 -0700
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100430 Fedora/3.0.4-3.fc13 Thunderbird/3.0.4
In-Reply-To: <87typdi44d.fsf@yoom.home.cworth.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148727>

On 06/08/2010 02:52 PM, Carl Worth wrote:
> 
> What do you mean by "most reliably handled format"?
> 

I have to say there is definitely part of me that thinks that using
base64 or quoted-unprintable for "^From "-containing mails might really
be the best solution... as much as I normally hate that crap.

	-hpa
