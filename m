From: Victor Engmark <victor.engmark@terreactive.ch>
Subject: Re: Which git command to be used to keep my local repo updated with
 the recent changes made to the original repo
Date: Thu, 27 Jan 2011 12:43:44 +0100
Organization: terreActive AG
Message-ID: <4D415A70.9000406@terreactive.ch>
References: <29999288.56562.1296123202254.JavaMail.trustmail@mail1.terreactive.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Akash <bcakashguru@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 27 12:43:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PiQGb-0002w2-HD
	for gcvg-git-2@lo.gmane.org; Thu, 27 Jan 2011 12:43:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754529Ab1A0Lnv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Jan 2011 06:43:51 -0500
Received: from gate.terreactive.ch ([212.90.202.121]:59104 "EHLO
	mail.terreactive.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754078Ab1A0Lnv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jan 2011 06:43:51 -0500
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101208 Thunderbird/3.1.7
In-Reply-To: <29999288.56562.1296123202254.JavaMail.trustmail@mail1.terreactive.ch>
X-terreActive-From: victor.engmark@terreactive.ch
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165574>

On 01/27/2011 11:13 AM, Akash wrote:
>
> I am new to git , So I just wanted to know which git command to be used to
> keep my local repo updated with the recent changes made to the original repo

$ git help pull

This command is a combination of `git fetch` (to get the commit data) 
and `git merge` (to merge that data with the current working copy).

Typically you want to get the data from the same place where you cloned 
from, in which case a simple `git pull` should be sufficient. If not, 
you should `git help remote` and `git help branch`.

-- 
Victor Engmark
