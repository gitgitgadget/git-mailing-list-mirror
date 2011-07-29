From: Allan Caffee <allan.caffee@gmail.com>
Subject: Unusual behavior from git describe
Date: Fri, 29 Jul 2011 17:46:45 -0400
Message-ID: <CA+jCPNcOe_dd6fsHDvWtoXEQE+xyd=aaSbfjpjQ8UfyFnvXTfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 29 23:46:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmutP-0003AL-8L
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jul 2011 23:46:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753117Ab1G2Vqq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jul 2011 17:46:46 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:45275 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752917Ab1G2Vqp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2011 17:46:45 -0400
Received: by iyb12 with SMTP id 12so4406236iyb.19
        for <git@vger.kernel.org>; Fri, 29 Jul 2011 14:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=GVz0ZLKnJSdZ5lmNjvC8s4/Gd3T5j4Wk9NThP7Zbj4w=;
        b=ptNeykwBEpYYdqFJnVl8tFRBiU8GSqO8Pjl/uery4u5RMMchbikKwTi7I4WdvaK2+T
         XQ1anled7hEva4Lt6UUtDMny4grGbGaeqwVrghq/ZVAWwb6tmPOZ11TXlU4B9Fwv0dd2
         J83zqHqGQtmSlYFferco+CcjPX7GqgYuLjvZo=
Received: by 10.231.141.207 with SMTP id n15mr1267430ibu.72.1311976005297;
 Fri, 29 Jul 2011 14:46:45 -0700 (PDT)
Received: by 10.231.199.148 with HTTP; Fri, 29 Jul 2011 14:46:45 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178169>

I've encountered some strange behavior from git describe.  Immediately
after building my python project with setuptools tools git describe
seems to think that the working tree is dirty.  However after running
git status (and seeing that nothing has changed) and running describe
again the dirtyness seems to have disappeared.  Any ideas as to what
might be going on here?

git is version 1.7.3.2 on Mac OSX.  The full transcript is below.

Thanks in advance,
Allan

% git describe --tags --dirty
v0.0.3

% python ./setup.py sdist
running sdist
running egg_info
writing requirements to flaskapi.egg-info/requires.txt
writing flaskapi.egg-info/PKG-INFO
writing top-level names to flaskapi.egg-info/top_level.txt
writing dependency_links to flaskapi.egg-info/dependency_links.txt
writing entry points to flaskapi.egg-info/entry_points.txt
reading manifest file 'flaskapi.egg-info/SOURCES.txt'
reading manifest template 'MANIFEST.in'
writing manifest file 'flaskapi.egg-info/SOURCES.txt'
warning: sdist: standard file not found: should have one of README, README.txt
warning: sdist: missing required meta-data: url
creating flaskapi-0.0.3
creating flaskapi-0.0.3/flaskapi
creating flaskapi-0.0.3/flaskapi.egg-info
creating flaskapi-0.0.3/flaskapi/apidoc
creating flaskapi-0.0.3/flaskapi/testing
creating flaskapi-0.0.3/tests
creating flaskapi-0.0.3/tests/integration
creating flaskapi-0.0.3/tests/unit
creating flaskapi-0.0.3/tests/unit/testing
making hard links in flaskapi-0.0.3...
hard linking MANIFEST.in -> flaskapi-0.0.3
hard linking RELEASE-VERSION -> flaskapi-0.0.3
hard linking fabfile.py -> flaskapi-0.0.3
hard linking setup.cfg -> flaskapi-0.0.3
hard linking setup.py -> flaskapi-0.0.3
hard linking version.py -> flaskapi-0.0.3
hard linking flaskapi/__init__.py -> flaskapi-0.0.3/flaskapi
hard linking flaskapi/app.py -> flaskapi-0.0.3/flaskapi
hard linking flaskapi/base_view.py -> flaskapi-0.0.3/flaskapi
hard linking flaskapi/errors.py -> flaskapi-0.0.3/flaskapi
hard linking flaskapi/helpers.py -> flaskapi-0.0.3/flaskapi
hard linking flaskapi/make_app.py -> flaskapi-0.0.3/flaskapi
hard linking flaskapi/registered_view_metaclass.py -> flaskapi-0.0.3/flaskapi
hard linking flaskapi.egg-info/PKG-INFO -> flaskapi-0.0.3/flaskapi.egg-info
hard linking flaskapi.egg-info/SOURCES.txt -> flaskapi-0.0.3/flaskapi.egg-info
hard linking flaskapi.egg-info/dependency_links.txt ->
flaskapi-0.0.3/flaskapi.egg-info
hard linking flaskapi.egg-info/entry_points.txt ->
flaskapi-0.0.3/flaskapi.egg-info
hard linking flaskapi.egg-info/not-zip-safe -> flaskapi-0.0.3/flaskapi.egg-info
hard linking flaskapi.egg-info/requires.txt -> flaskapi-0.0.3/flaskapi.egg-info
hard linking flaskapi.egg-info/top_level.txt -> flaskapi-0.0.3/flaskapi.egg-info
hard linking flaskapi/apidoc/__init__.py -> flaskapi-0.0.3/flaskapi/apidoc
hard linking flaskapi/testing/__init__.py -> flaskapi-0.0.3/flaskapi/testing
hard linking flaskapi/testing/base_api_test.py ->
flaskapi-0.0.3/flaskapi/testing
hard linking flaskapi/testing/json_helpers.py -> flaskapi-0.0.3/flaskapi/testing
hard linking flaskapi/testing/json_requester.py ->
flaskapi-0.0.3/flaskapi/testing
hard linking tests/__init__.py -> flaskapi-0.0.3/tests
hard linking tests/integration/__init__.py -> flaskapi-0.0.3/tests/integration
hard linking tests/unit/__init__.py -> flaskapi-0.0.3/tests/unit
hard linking tests/unit/test_base_view.py -> flaskapi-0.0.3/tests/unit
hard linking tests/unit/test_errors.py -> flaskapi-0.0.3/tests/unit
hard linking tests/unit/test_helpers.py -> flaskapi-0.0.3/tests/unit
hard linking tests/unit/test_make_app.py -> flaskapi-0.0.3/tests/unit
hard linking tests/unit/test_registered_view_metaclass.py ->
flaskapi-0.0.3/tests/unit
hard linking tests/unit/testing/__init__.py -> flaskapi-0.0.3/tests/unit/testing
hard linking tests/unit/testing/test_base_api_test.py ->
flaskapi-0.0.3/tests/unit/testing
hard linking tests/unit/testing/test_json_helpers.py ->
flaskapi-0.0.3/tests/unit/testing
copying setup.cfg -> flaskapi-0.0.3
Writing flaskapi-0.0.3/setup.cfg
tar -cf dist/flaskapi-0.0.3.tar flaskapi-0.0.3
gzip -f9 dist/flaskapi-0.0.3.tar
tar -cf dist/flaskapi-0.0.3.tar flaskapi-0.0.3
gzip -f9 dist/flaskapi-0.0.3.tar
removing 'flaskapi-0.0.3' (and everything under it)

% git describe --tags --dirty
v0.0.3-dirty

% git status
# On branch master
nothing to commit (working directory clean)

% git describe --tags --dirty
v0.0.3
