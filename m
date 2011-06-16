From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Copying Git repository from Linux to Windows.
Date: Thu, 16 Jun 2011 10:50:02 +0200
Message-ID: <4DF9C3BA.8010106@viscovery.net>
References: <4DF87B42.1020004@st.com> <m3ei2vv0nw.fsf@localhost.localdomain> <4DF891CC.1040700@st.com> <BANLkTik+oUb1QpVTwJfB30_8FsW=4ZVTxA@mail.gmail.com> <4DF89F56.3060200@st.com> <4DF8A896.7080708@op5.se> <4DF97998.7070604@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Andreas Ericsson <ae@op5.se>,
	"kusmabite@gmail.com" <kusmabite@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Shiraz HASHIM <shiraz.hashim@st.com>,
	Vipin KUMAR <vipin.kumar@st.com>
To: viresh kumar <viresh.kumar@st.com>
X-From: git-owner@vger.kernel.org Thu Jun 16 10:50:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QX8HI-0007eV-Jj
	for gcvg-git-2@lo.gmane.org; Thu, 16 Jun 2011 10:50:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757117Ab1FPIuL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jun 2011 04:50:11 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:27472 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755722Ab1FPIuK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2011 04:50:10 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1QX8H8-0002Ju-2A; Thu, 16 Jun 2011 10:50:06 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 4336B1660F;
	Thu, 16 Jun 2011 10:50:02 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
In-Reply-To: <4DF97998.7070604@st.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175887>

Am 6/16/2011 5:33, schrieb viresh kumar:
> And i wanted just linux source on windows, i will not be creating any patches from
> windows. Just needed code for reference.

If you only want to peek into the files, you don't need the files checked
out. Just have them in a bare repository and use, e.g.,

  git show master:mm/vmalloc.c

You can also use a sparse checkout to omit the questionable files from the
checkout. See man git-read-tree.

-- Hannes
