From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [ANNOUNCE] git-multimail organizational changes
Date: Wed, 22 Apr 2015 16:45:56 +0200
Message-ID: <5537B424.60200@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 22 16:46:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ykvuo-0008RP-Bq
	for gcvg-git-2@plane.gmane.org; Wed, 22 Apr 2015 16:46:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933807AbbDVOqK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2015 10:46:10 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:50718 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933659AbbDVOqI (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Apr 2015 10:46:08 -0400
X-AuditID: 1207440d-f79976d000005643-e2-5537b4260bd3
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 17.C9.22083.624B7355; Wed, 22 Apr 2015 10:45:58 -0400 (EDT)
Received: from [192.168.69.130] (p4FC971D5.dip0.t-ipconnect.de [79.201.113.213])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t3MEjuTF017931
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 22 Apr 2015 10:45:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHIsWRmVeSWpSXmKPExsUixO6iqKu2xTzU4M8ufouuK91MFpc+r2d1
	YPKY+OU4q8fnTXIBTFHcNkmJJWXBmel5+nYJ3BmPvs1lL/jIWdG3fjdjA+M99i5GTg4JAROJ
	lX+es0HYYhIX7q0Hsrk4hAQuM0ps3LSPHcK5wCQxcfNHli5GDg5eAU2JxgMyIA0sAqoS/ydc
	A2tmE9CVWNTTzARiiwoESbRem8oIYvMKCEqcnPmEBcQWAarZ9ewqWD2zgL7E7AnnmEFGCgtY
	SLQvVYAIq0v8mXeJGcKWl2jeOpt5AiPfLCSTZiEpm4WkbAEj8ypGucSc0lzd3MTMnOLUZN3i
	5MS8vNQiXSO93MwSvdSU0k2MkLDj3cH4f53MIUYBDkYlHt4AVvNQIdbEsuLK3EOMkhxMSqK8
	H9cBhfiS8lMqMxKLM+KLSnNSiw8xSnAwK4nwii4FyvGmJFZWpRblw6SkOViUxHnVlqj7CQmk
	J5akZqemFqQWwWRlODiUJHijNwE1ChalpqdWpGXmlCCkmTg4QYZzSYkUp+alpBYllpZkxIPi
	Lr4YGHkgKR6gvR9B2nmLCxJzgaIQracYFaXEeQ+BJARAEhmleXBjYcnkFaM40JfCvAybgap4
	gIkIrvsV0GAmoMFx20xABpckIqSkGhh1W9xWba5Zd+sw+6/NZnlK7mIuijeZypj9J9Z632mI
	OWNewG3+xWmFT1DYznTug8fmaajmGjyb/zg3IW/He8YvM6TniD8Wdd6+eade5zb2t29vPKt0
	29amxmm646b6fY+5vzZvW+Z/qe45pyjHFQkLzrhJqlqRd6dFpDxmtex123rvUTZ3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267593>

git-multimail is a server hook that sends email notifications for git
pushes.

I'd like to announce a few changes in the git-multimail project that
will hopefully lessen its dependence on me [1]:

* I've created a GitHub organization to house the main repository
  (previously it was under my own GitHub account).

  Its new main page is

      https://github.com/git-multimail/git-multimail

  The old GitHub pages should redirect here, but anybody who fetches
  from this repo will have to update his/her git remote configuration.

* Matthieu Moy has agreed to become a co-maintainer. He uses
  git-multimail and has submitted patches in the past, so his
  participation is very welcome.

* If anybody else would like to get involved in maintaining and/or
  improving git-multimail, please let me and Matthieu know. There are
  a bunch of pending pull requests that need attention, so feel free
  to jump in with code review, testing, or whatever.

Michael

[1] I feel terrible about my neglect of the project. I've been
    too busy with my day job and this project has suffered. I also
    don't use git-multimail anymore myself, so I don't experience
    the itches of its users.

-- 
Michael Haggerty
mhagger@alum.mit.edu
