From: Samuel Lucas Vaz de Mello <samuellucas@datacom.ind.br>
Subject: Blamming a diff between two commits?
Date: Tue, 17 Feb 2009 10:16:17 -0300
Organization: DATACOM
Message-ID: <499AB8A1.7090909@datacom.ind.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 17 14:37:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZQ8v-00031l-4D
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 14:37:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbZBQNgR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 08:36:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750938AbZBQNgR
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 08:36:17 -0500
Received: from mail.datacom-telematica.com.br ([200.213.13.18]:47642 "EHLO
	mail.datacom-telematica.com.br" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750833AbZBQNgQ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Feb 2009 08:36:16 -0500
X-Greylist: delayed 1223 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Feb 2009 08:36:15 EST
Received: by mail.datacom-telematica.com.br (Postfix, from userid 65)
	id 087CB2AD08; Tue, 17 Feb 2009 10:15:45 -0300 (BRT)
Received: from [10.1.3.11] (unknown [10.1.3.11])
	by mail.datacom-telematica.com.br (Postfix) with ESMTP id AA2AF2AD07
	for <git@vger.kernel.org>; Tue, 17 Feb 2009 10:15:45 -0300 (BRT)
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110369>

Hi,

Is there any way to git blame (or annotate) a diff between two commits?

I'm looking for something that produce something like this:

                              /**
85a02065 (samuel 2009-01-02) - * \brief      Define a participacao da porta estatica/dinamica
85a02065 (samuel 2009-01-02) - * \param      unit            indice da unidade
e106303a (arthur 2009-01-17) - * \param	     extraparam      extra parameter
85a02065 (samuel 2009-01-02) - * \param      port            indice da porta
50e22e7d (fabian 2009-01-09) - * \param      deleted         param to be deleted
85a02065 (samuel 2009-01-02) + * \brief      Sets port membership on a static / dynamic 
85a02065 (samuel 2009-01-02) + * \param      unit            unit index
85a02065 (samuel 2009-01-02) + * \param      port            port index
e106303a (arthur 2009-01-17) + * \param	     another         another index
                               * \return     0 if Ok; -1 in error
                               */

This would be useful for code reviews. I can use a diff containing all changes committed to a branch, for example, in the last 10 days to review. Doing this instead of reviewing individual commit patches save us from waste time analyzing code that has already been changed/fixed. 

Using a git-blame in the resulting file give me the commits for the lines added, but not for the deleted ones.

Any suggestion on how to do this?


Thanks,

 - Samuel
