From: public_vi <public_vi@tut.by>
Subject: Re: How to build git-remote-http properly?
Date: Tue, 09 Nov 2010 03:50:06 +0200
Message-ID: <4CD8A8CE.4060000@tut.by>
References: <4CD8A6FA.8030506@tut.by>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 09 02:50:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFdML-0005Ca-SH
	for gcvg-git-2@lo.gmane.org; Tue, 09 Nov 2010 02:50:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754464Ab0KIBus (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Nov 2010 20:50:48 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:48367 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753870Ab0KIBur (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Nov 2010 20:50:47 -0500
Received: by eye27 with SMTP id 27so3283811eye.19
        for <git@vger.kernel.org>; Mon, 08 Nov 2010 17:50:46 -0800 (PST)
Received: by 10.213.28.8 with SMTP id k8mr4569956ebc.12.1289267445608;
        Mon, 08 Nov 2010 17:50:45 -0800 (PST)
Received: from [0.0.0.0] ([80.83.124.150])
        by mx.google.com with ESMTPS id b52sm595587eei.1.2010.11.08.17.50.43
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 08 Nov 2010 17:50:44 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.12) Gecko/20100913 Icedove/3.0.7
In-Reply-To: <4CD8A6FA.8030506@tut.by>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161010>

Have found the problem right after sending the letter:
/usr/local/lib contained bad libcurl/libexpat. Removing them immediately 
fixed things.

On 11/09/2010 03:42 AM, public_vi wrote:
> I have built git from sources, but git-remote-http[s] does not work: 
> it sends invalid data.
>
> https://gist.github.com/667250
